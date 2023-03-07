import 'dart:convert';

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/service_locator.dart';

class MealServiceApi extends MealService {
  final HttpService _httpService = getIt<HttpService>();

  static const controllerName = 'Meal';

  @override
  Future<bool> createMeal(MealModel meal) async {
    var response =
        await _httpService.post(controllerName, [], [], meal.toJson());
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<bool> deleteMeal(int mealId) async {
    var response = await _httpService.delete(controllerName, mealId);
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<List<MealModel>> getAllMealsByUserIdAndDate(
      int? userId, DateTime date) async {
    List<MealModel> mealList = [];
    var response = await _httpService.get(controllerName, null,
        ['userId', 'date'], [userId.toString(), date.toIso8601String()]);
    if (_httpService.isResponseOk(response.statusCode)) {
      final List untypedObjects = jsonDecode(response.body);
      mealList = untypedObjects.map((e) => MealModel.fromJson(e)).toList();
    }
    return mealList;
  }

  @override
  Future<MealModel> getMealById(int mealId) async {
    MealModel meal = MealModel();
    var response =
        await _httpService.get(controllerName, 'meal/$mealId', [], []);

    if (_httpService.isResponseOk(response.statusCode)) {
      final Map<String, dynamic> untypedObject = jsonDecode(response.body);
      meal = MealModel.fromJson(untypedObject);
    }
    return meal;
  }

  @override
  Future<bool> updateMeal(MealModel meal) async {
    var response =
        await _httpService.put(controllerName, [], [], meal.toJson());
    return _httpService.isResponseOk(response.statusCode);
  }
}
