import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
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
  Future<List<NutritionGoalModel>> getAllNutritionGoalsByUserIdAndDate(
      int? userId, DateTime date) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString(),
      "date": date.toIso8601String()
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<NutritionGoalModel> nutritionGoalList =
        untypedObjects.map((e) => NutritionGoalModel.fromJson(e)).toList();

    return nutritionGoalList;
  }

  @override
  Future<bool> updateNutritionGoal(
      UpdateNutritionGoalRequest updatedNutritionGoal) async {
    var response = await http.put(url,
        headers: headers, body: updatedNutritionGoal.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
