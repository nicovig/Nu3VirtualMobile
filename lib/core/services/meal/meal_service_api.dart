import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';

class MealServiceApi extends MealService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost = '10.0.2.2:';
  static const apiUrl = '44383';
  static const controllerName = 'Meal';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<bool> createMeal(MealModel meal) async {
    var response = await http.post(url, headers: headers, body: meal.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteMeals(List<int> mealIds) async {
    var response = await http.delete(url, headers: headers, body: mealIds);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<MealModel>> getAllMealsByUserIdAndDate(
      int? userId, DateTime date) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": "${userId.toString()}",
      "date": "${date.toIso8601String()}"
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<MealModel> mealList =
        untypedObjects.map((e) => MealModel.fromJson(e)).toList();

    return mealList;
  }

  @override
  Future<bool> updateMeal(MealModel meal) async {
    var response = await http.put(url, headers: headers, body: meal.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
