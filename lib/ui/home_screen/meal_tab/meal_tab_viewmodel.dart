import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealTabViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  List<MealModel> meals = [];
  List<MealModel> mealsDisplayed = [];
  int? userId = 0;

  Future loadData(DateTime date) async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await getMeals(DateTime.now());

    notifyListeners();
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

  Future getMeals(DateTime date) async {
    meals = await _mealService.getAllMealsByUserIdAndDate(userId, date);
    mealsDisplayed = meals;
    notifyListeners();
  }

  Future updateMeal(MealModel meal, BuildContext dialogContext) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    Navigator.pop(dialogContext, isUpdateOk);
    notifyListeners();
  }
}
