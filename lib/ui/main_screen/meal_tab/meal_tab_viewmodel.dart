import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/favorite_meal_model.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealTabViewModel extends ChangeNotifier {
  final FavoriteMealService _favoriteMealService = getIt<FavoriteMealService>();
  final MealService _mealService = getIt<MealService>();
  final MonitoringService _monitoringService = getIt<MonitoringService>();
  final UserStore _userStore = getIt<UserStore>();

  List<FavoriteMealModel> favoritesMeals = [];
  List<MealModel> meals = [];
  MonitoringModel monitoringDisplayed = MonitoringModel();
  int? userId = 0;

  Future addFavoriteMealToDailyMeals(
      int favoriteMealId, DateTime date, BuildContext dialogContext) async {
    date = DateTime(date.year, date.month, date.day, TimeOfDay.now().hour,
        TimeOfDay.now().minute);
    bool isAddOk = await _favoriteMealService.addFavoriteMealToDailyMeals(
        favoriteMealId, date, userId ?? 0);
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

  Future initData(DateTime date) async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await loadData(date);
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    await _getFavoritesMeals(date);
    await _getMeals(date);
    await _getMonitoring(date);
    notifyListeners();
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

  Future _getFavoritesMeals(DateTime date) async {
    favoritesMeals =
        await _favoriteMealService.getAllFavoriteMealsByUserId(userId ?? 0);
    notifyListeners();
  }

  Future _getMeals(DateTime date) async {
    meals = await _mealService.getAllMealsByUserIdAndDate(userId, date);
    notifyListeners();
  }

  Future _getMonitoring(DateTime date) async {
    monitoringDisplayed =
        await _monitoringService.getMonitoringByUserIdAndDate(userId, date);
    notifyListeners();
  }
}
