import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/nutrition_goals_model.dart';

class InformationsTabViewModel extends ChangeNotifier {
  List<NutritionGoalsModel> informationGoals = [
    NutritionGoalsModel(
        id: 1,
        order: 1,
        name: 'Calories',
        date: DateTime.now(),
        goalAchievedValue: 1400,
        goalTotalValue: 1750,
        goalAchievedRatio: 0.87),
    NutritionGoalsModel(
        id: 2,
        order: 2,
        name: 'Glucides',
        date: DateTime.now(),
        goalAchievedValue: 1400,
        goalTotalValue: 1750,
        goalAchievedRatio: 0.87),
    NutritionGoalsModel(
        id: 3,
        order: 3,
        name: 'Lipides',
        date: DateTime.now(),
        goalAchievedValue: 1400,
        goalTotalValue: 1750,
        goalAchievedRatio: 0.87),
    NutritionGoalsModel(
        id: 4,
        order: 4,
        name: 'Protéines',
        date: DateTime.now(),
        goalAchievedValue: 1400,
        goalTotalValue: 1750,
        goalAchievedRatio: 0.87),
  ];

  Future initData() async {
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    notifyListeners();
  }
}
