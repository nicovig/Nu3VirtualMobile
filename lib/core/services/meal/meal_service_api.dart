import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/meal_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/meal/meal_service.dart';
import 'package:nu3virtual/service_locator.dart';

class MealServiceApi extends MealService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: ''
  };
  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'Meal';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<bool> createMeal(MealModel meal) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    var response = await http.post(url, headers: headers, body: meal.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteMeal(int mealId) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    Uri customUrl = Uri.https(
        hostedDeviceLocalhost + apiUrl, '$controllerName/${mealId.toString()}');
    var response = await http.delete(customUrl, headers: headers);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<MealModel>> getAllMealsByUserIdAndDate(
      int? userId, DateTime date) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    headers['userId'] = userId.toString();
    headers['date'] = await date.toIso8601String();

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
  Future<MealModel> getMealById(
    int mealId,
  ) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    Uri newUrl = Uri.https(
        hostedDeviceLocalhost + apiUrl, '$controllerName/meal/$mealId');
    var response = await http.get(
      newUrl,
      headers: headers,
    );

    final Map<String, dynamic> untypedObject = jsonDecode(response.body);
    final MealModel meal = MealModel.fromJson(untypedObject);

    return meal;
  }

  @override
  Future<bool> updateMeal(MealModel meal) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    var response = await http.put(url, headers: headers, body: meal.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
