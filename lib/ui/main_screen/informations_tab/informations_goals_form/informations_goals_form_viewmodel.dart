import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/nutrition_goal/models/update_nutrition_goals_request.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class InformationsGoalsFormViewModel extends ChangeNotifier {
  final NutritionGoalService _nutritionGoalService =
      getIt<NutritionGoalService>();
  final UserStore _userStore = getIt<UserStore>();

  late UserModel user = UserModel();
  List<NutritionGoalDisplayedModel> nutritionGoals = [];

  Future<List<NutritionGoalDisplayedModel>> loadData() async {
    user = await _userStore.getCurrentUser();
    return Future<List<NutritionGoalDisplayedModel>>.delayed(
        const Duration(seconds: 1),
        () => _nutritionGoalService.getAllNutritionGoalsByUserId(user.id));
  }

  Future updateNutritionGoals(BuildContext context) async {
    List<UpdateNutritionGoalRequest> updatedNutritionGoals = [];

    nutritionGoals.forEach((nutritionGoal) {
      updatedNutritionGoals.add(UpdateNutritionGoalRequest(
          id: nutritionGoal.id ?? 0,
          order: nutritionGoal.order ?? 0,
          totalValue: nutritionGoal.totalValue ?? 0));
    });

    UpdateNutritionGoalsRequest allUpdatedNutritionGoals =
        UpdateNutritionGoalsRequest(nutritionGoals: updatedNutritionGoals);

    bool isUpdateOk = await _nutritionGoalService
        .updateNutritionGoals(allUpdatedNutritionGoals);
    if (isUpdateOk) {
      _redirectToInformationsTab(context);
    }
    notifyListeners();
  }

  _redirectToInformationsTab(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
        arguments: MainScreenTabEnum.informations.index);
  }
}
