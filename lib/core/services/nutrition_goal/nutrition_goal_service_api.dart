import 'dart:convert';

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/nutrition_goal/models/update_nutrition_goals_request.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';
import 'package:nu3virtual/service_locator.dart';

class NutritionServiceApi extends NutritionGoalService {
  final HttpService _httpService = getIt<HttpService>();

  static const controllerName = 'NutritionGoal';

  @override
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserId(
      int? userId) async {
    var response = await _httpService
        .get(controllerName, null, ['userId'], [userId.toString()]);

    final List untypedObjects = jsonDecode(response.body);
    final List<NutritionGoalDisplayedModel> nutritionGoalList = untypedObjects
        .map((e) => NutritionGoalDisplayedModel.fromJson(e))
        .toList();
    return nutritionGoalList;
  }

  @override
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserIdAndDate(
      int? userId, DateTime date) async {
    List<NutritionGoalDisplayedModel> nutritionGoalList = [];
    var response = await _httpService.get(controllerName, 'withDate',
        ['userId', 'date'], [userId.toString(), date.toIso8601String()]);
    if (_httpService.isResponseOk(response.statusCode)) {
      final List untypedObjects = jsonDecode(response.body);
      nutritionGoalList = untypedObjects
          .map((e) => NutritionGoalDisplayedModel.fromJson(e))
          .toList();
    }
    return nutritionGoalList;
  }

  @override
  Future<bool> updateNutritionGoals(
      UpdateNutritionGoalsRequest updatedNutritionGoals) async {
    var response = await _httpService.put(
        controllerName, [], [], updatedNutritionGoals.toJson());
    return _httpService.isResponseOk(response.statusCode);
  }
}
