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
  int? userId = 0;

  Future loadData(DateTime date) async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    meals = await _mealService.getAllMealsByUserIdAndDate(userId, date);
    notifyListeners();
  }

  addMeal(MealModel meal, BuildContext dialogContext) async {
    bool isCreationOk = await _mealService.createMeal(meal);
    Navigator.pop(dialogContext, isCreationOk);
    notifyListeners();
  }
}
