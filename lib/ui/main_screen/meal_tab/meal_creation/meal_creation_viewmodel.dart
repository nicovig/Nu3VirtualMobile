import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealCreationViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();
  final MonitoringService _monitoringService = getIt<MonitoringService>();
  final UserStore _userStore = getIt<UserStore>();

  late MealModel meal;
  late MealModel mealDisplayed;
  late UserModel user = UserModel();

  Future addMeal(MealModel meal, BuildContext dialogContext) async {
    bool isCreateOk = await _mealService.createMeal(meal);
    if (isCreateOk) {
      _redirectToMealTab() {}
    }
    notifyListeners();
  }

  Future getMealById(int mealId) async {
    user = await _userStore.getCurrentUser();

    if (mealId != 0) {
      meal = await _mealService.getMealById(mealId);
    } else {
      meal = MealModel(
          name: '',
          type: MealTypeEnum.snack,
          isFavorite: false,
          date: DateTime.now(),
          carbohydrate: 0,
          lipid: 0,
          protein: 0,
          calorie: 0,
          notes: '',
          userId: user.id);
    }

    mealDisplayed = meal;
    notifyListeners();
  }

  handleValidation(MealModel meal) {}

  Future updateMeal(MealModel meal, BuildContext dialogContext) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    if (isUpdateOk) {
      _redirectToMealTab() {}
    }
    notifyListeners();
  }

  _redirectToMealTab() {}
}
