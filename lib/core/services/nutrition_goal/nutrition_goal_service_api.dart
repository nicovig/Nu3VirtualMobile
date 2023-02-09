import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/services/nutrition_goal/models/update_nutrition_goals_request.dart';
import 'package:nu3virtual/core/services/nutrition_goal/nutrition_goal_service.dart';

class NutritionServiceApi extends NutritionGoalService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'NutritionGoal';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserId(
      int? userId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString()
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<NutritionGoalDisplayedModel> nutritionGoalList = untypedObjects
        .map((e) => NutritionGoalDisplayedModel.fromJson(e))
        .toList();

    return nutritionGoalList;
  }

  @override
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserIdAndDate(
      int? userId, DateTime date) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString(),
      "date": date.toIso8601String()
    };

    Uri newUrl =
        Uri.https(hostedDeviceLocalhost + apiUrl, '$controllerName/withDate');

    var response = await http.get(
      newUrl,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<NutritionGoalDisplayedModel> nutritionGoalList = untypedObjects
        .map((e) => NutritionGoalDisplayedModel.fromJson(e))
        .toList();

    return nutritionGoalList;
  }

  @override
  Future<bool> updateNutritionGoals(
      UpdateNutritionGoalsRequest updatedNutritionGoals) async {
    var response = await http.put(url,
        headers: headers, body: updatedNutritionGoals.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
