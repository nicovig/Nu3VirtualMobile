import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MealCreationViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  late MealModel meal = MealModel();
  late UserModel user = UserModel();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  handleValidation(BuildContext context) async {
    meal.userId = user.id;
    meal.id == null
        ? await _addMeal(meal, context)
        : await _updateMeal(meal, context);
  }

  Future<MealModel> loadData(int mealId) async {
    user = await _userStore.getCurrentUser();
    if (mealId != 0) {
      return Future<MealModel>.delayed(
          const Duration(seconds: 1), () => _mealService.getMealById(mealId));
    } else {
      return Future<MealModel>.delayed(
          const Duration(seconds: 1),
          () => MealModel(
              id: 0,
              name: '',
              type: MealTypeEnum.snack,
              isFavorite: false,
              date: DateTime.now(),
              carbohydrate: 0,
              lipid: 0,
              protein: 0,
              calorie: 0,
              notes: '',
              userId: user.id));
    }
  }

  Future _addMeal(MealModel meal, BuildContext context) async {
    meal.id = 0;
    bool isUpdateOk = await _mealService.createMeal(meal);
    if (isUpdateOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  Future _updateMeal(MealModel meal, BuildContext context) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    if (isUpdateOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  _redirectToMealTab(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
  }
}
