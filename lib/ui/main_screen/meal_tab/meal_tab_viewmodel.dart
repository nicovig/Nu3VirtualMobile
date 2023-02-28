import 'package:flutter/material.dart';

import 'package:event/event.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealTabViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final FavoriteMealService _favoriteMealService = getIt<FavoriteMealService>();
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  List<FavoriteMealModel> favoritesMeals = [];
  List<MealModel> meals = [];
  int? userId = 0;

  Future addFavoriteMealToDailyMeals(
      BuildContext dialogContext, int favoriteMealId) async {
    DateTime currentDate = await _dateStore.getDate();
    DateTime favoriteMealDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, TimeOfDay.now().hour, TimeOfDay.now().minute);

    bool isAddOk = await _favoriteMealService.addFavoriteMealToDailyMeals(
        favoriteMealId, favoriteMealDate, userId ?? 0);
    Navigator.of(dialogContext).pop(isAddOk);
    notifyListeners();
  }

  Future deleteFavoriteMeal(int favoriteMealId) async {
    await _favoriteMealService.deleteFavoriteMeal(favoriteMealId);
    notifyListeners();
  }

  Future deleteMeal(int mealId, BuildContext dialogContext) async {
    bool isDeleteOk = await _mealService.deleteMeal(mealId);
    Navigator.of(dialogContext).pop(isDeleteOk);
    notifyListeners();
  }

  Future initData(Event<EventArgs> dateChangeEvent) async {
    _dateChangeSubscribe(dateChangeEvent);
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await loadData();
    notifyListeners();
  }

  Future loadData() async {
    DateTime currentDate = await _dateStore.getDate();
    await _getFavoritesMeals();
    await _getMeals(currentDate);
    notifyListeners();
  }

  openFavoriteMealScreen(BuildContext context) {
    Navigator.pushNamed(context, favoriteMealsRoute);
  }

  openMealScreen(BuildContext context, int mealId) {
    Navigator.pushNamed(
      context,
      mealRoute,
      arguments: mealId,
    );
  }

  Future updateMeal(MealModel meal, BuildContext dialogContext) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    Navigator.pop(dialogContext, isUpdateOk);
    notifyListeners();
  }

  void _dateChangeSubscribe(Event<EventArgs> dateChangeEvent) {
    dateChangeEvent.subscribe((args) async {
      await loadData();
    });
  }

  Future _getFavoritesMeals() async {
    favoritesMeals =
        await _favoriteMealService.getAllFavoriteMealsByUserId(userId ?? 0);
    notifyListeners();
  }

  Future _getMeals(DateTime date) async {
    meals = await _mealService.getAllMealsByUserIdAndDate(userId, date);
    notifyListeners();
  }
}
