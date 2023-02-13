import 'package:event/event.dart';
import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class FavoriteMealViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final FavoriteMealService _favoriteMealService = getIt<FavoriteMealService>();
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  List<FavoriteMealModel> favoritesMeals = [];
  List<MealModel> meals = [];
  late UserModel user = UserModel();

  Future addFavoriteMealToDailyMeals(
      BuildContext dialogContext, int favoriteMealId) async {
    DateTime currentDate = await _dateStore.getDate();
    DateTime favoriteMealDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, TimeOfDay.now().hour, TimeOfDay.now().minute);

    bool isAddOk = await _favoriteMealService.addFavoriteMealToDailyMeals(
        favoriteMealId, favoriteMealDate, user.id ?? 0);
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

  Future<List<FavoriteMealModel>> loadData() async {
    user = await _userStore.getCurrentUser();
    DateTime currentDate = await _dateStore.getDate();
    return _getFavoritesMeals(currentDate);
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

  Future<List<FavoriteMealModel>> _getFavoritesMeals(DateTime date) async {
    return Future<List<FavoriteMealModel>>.delayed(const Duration(seconds: 1),
        () => _favoriteMealService.getAllFavoriteMealsByUserId(user.id ?? 0));
  }
}
