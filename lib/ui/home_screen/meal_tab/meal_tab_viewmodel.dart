import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/service_locator.dart';

class MealTabViewModel extends ChangeNotifier {
  final MealService _mealService = getIt<MealService>();

  Future loadData() async {
    notifyListeners();
  }

  addMeal(MealModel meal, BuildContext dialogContext) async {
    bool isCreationOk = await _mealService.createMeal(meal);
    Navigator.pop(dialogContext, isCreationOk);
    notifyListeners();
  }
}
