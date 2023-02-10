import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class MealFormViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  late MealModel meal = MealModel();
  late UserModel user = UserModel();

  handleValidation(BuildContext context) async {
    meal.userId = user.id;
    meal.id == 0 ? await _addMeal(context) : await _updateMeal(context);
  }

  Future<MealModel> loadData(int mealId) async {
    user = await _userStore.getCurrentUser();
    if (mealId != 0) {
      return Future<MealModel>.delayed(
          const Duration(seconds: 1), () => _mealService.getMealById(mealId));
    } else {
      DateTime currentDate = await _dateStore.getDate();
      return Future<MealModel>.delayed(
          const Duration(seconds: 0),
          () => MealModel(
              id: 0,
              name: '',
              type: MealTypeEnum.snack,
              isFavorite: false,
              date: DateTime(
                  currentDate.year,
                  currentDate.month,
                  currentDate.day,
                  TimeOfDay.now().hour,
                  TimeOfDay.now().minute),
              carbohydrate: 0,
              lipid: 0,
              protein: 0,
              calorie: 0,
              notes: '',
              userId: user.id));
    }
  }

  Future _addMeal(BuildContext context) async {
    bool isUpdateOk = await _mealService.createMeal(meal);
    if (isUpdateOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  Future _updateMeal(BuildContext context) async {
    bool isUpdateOk = await _mealService.updateMeal(meal);
    if (isUpdateOk) {
      _redirectToMealTab(context);
    }
    notifyListeners();
  }

  _redirectToMealTab(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
        arguments: MainScreenTabEnum.meals.index);
  }
}
