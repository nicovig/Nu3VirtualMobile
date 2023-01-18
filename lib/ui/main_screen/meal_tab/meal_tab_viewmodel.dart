import 'package:flutter/widgets.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealTabViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();
  final MonitoringService _monitoringService = getIt<MonitoringService>();
  final UserStore _userStore = getIt<UserStore>();

  List<MealModel> meals = [];
  List<MealModel> mealsDisplayed = [];
  MonitoringModel monitoringDisplayed = MonitoringModel();
  int? userId = 0;

  Future initData(DateTime date) async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await loadData(date);
    notifyListeners();
  }

  addMealScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      mealRoute,
      arguments: 0,
    );
  }

  Future addMeal(MealModel meal, BuildContext dialogContext) async {
    bool isCreateOk = await _mealService.createMeal(meal);
    Navigator.pop(dialogContext, isCreateOk);
    notifyListeners();
  }

  Future deleteMeal(int mealId, BuildContext dialogContext) async {
    bool isDeleteOk = await _mealService.deleteMeal(mealId);
    Navigator.of(dialogContext).pop(isDeleteOk);
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    await _getMeals(date);
    await _getMonitoring(date);
    notifyListeners();
  }

  Future updateMeal(MealModel meal, BuildContext dialogContext) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    Navigator.pop(dialogContext, isUpdateOk);
    notifyListeners();
  }

  Future _getMeals(DateTime date) async {
    meals = await _mealService.getAllMealsByUserIdAndDate(userId, date);
    mealsDisplayed = meals;
    notifyListeners();
  }

  Future _getMonitoring(DateTime date) async {
    monitoringDisplayed =
        await _monitoringService.getMonitoringByUserIdAndDate(userId, date);
    notifyListeners();
  }
}
