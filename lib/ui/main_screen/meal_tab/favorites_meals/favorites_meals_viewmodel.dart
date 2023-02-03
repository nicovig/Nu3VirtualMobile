import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class FavoritesMealsViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();
  final UserStore _userStore = getIt<UserStore>();

  late MealModel meal = MealModel();
  late UserModel user = UserModel();

  Future addFavoritesMealsToMeals(BuildContext context) async {
    notifyListeners();
  }

  Future deleteFavoriteMeal(BuildContext context) async {
    notifyListeners();
  }

  Future loadData() async {
    user = await _userStore.getCurrentUser();
  }
}
