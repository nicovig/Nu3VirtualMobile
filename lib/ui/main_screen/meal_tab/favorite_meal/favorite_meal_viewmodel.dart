import 'package:flutter/material.dart';

import 'package:event/event.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class FavoriteMealViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final FavoriteMealService _favoriteMealService = getIt<FavoriteMealService>();

  final UserStore _userStore = getIt<UserStore>();

  List<FavoriteMealModel> favoritesMealsDisplayed = [];
  List<MealModel> meals = [];
  late UserModel user = UserModel();

  Future addFavoriteMealToDailyMeals(
      BuildContext context, int favoriteMealId) async {
    DateTime currentDate = await _dateStore.getDate();
    DateTime favoriteMealDate = DateTime(currentDate.year, currentDate.month,
        currentDate.day, TimeOfDay.now().hour, TimeOfDay.now().minute);

    bool isAddOk = await _favoriteMealService.addFavoriteMealToDailyMeals(
        favoriteMealId, favoriteMealDate, user.id ?? 0);
    if (isAddOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  Future deleteFavoriteMeal(BuildContext context, int favoriteMealId) async {
    bool isDeleteOk =
        await _favoriteMealService.deleteFavoriteMeal(favoriteMealId);
    if (isDeleteOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  Future<List<FavoriteMealModel>> loadData() async {
    user = await _userStore.getCurrentUser();
    DateTime currentDate = await _dateStore.getDate();
    return _getFavoritesMeals(currentDate);
  }

  Future<List<FavoriteMealModel>> _getFavoritesMeals(DateTime date) async {
    return Future<List<FavoriteMealModel>>.delayed(const Duration(seconds: 1),
        () => _favoriteMealService.getAllFavoriteMealsByUserId(user.id ?? 0));
  }

  _redirectToMealTab(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
        arguments: MainScreenTabEnum.meals.index);
  }
}
