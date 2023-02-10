import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/favorite_meal_model.dart';

import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';

class FavoriteMealServiceApi extends FavoriteMealService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'FavoriteMeal';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<bool> addFavoriteMealToDailyMeals(
      int favoriteMealId, DateTime date, int userId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString()
    };

    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          'date': date.toIso8601String(),
          'favoriteMealId': favoriteMealId
        }));

    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteFavoriteMeal(int favoriteMealId) async {
    Uri customUrl = Uri.https(hostedDeviceLocalhost + apiUrl,
        '$controllerName/${favoriteMealId.toString()}');
    var response = await http.delete(customUrl, headers: headers);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<FavoriteMealModel>> getAllFavoriteMealsByUserId(
      int userId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString(),
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<FavoriteMealModel> mealList =
        untypedObjects.map((e) => FavoriteMealModel.fromJson(e)).toList();

    return mealList;
  }

  @override
  Future<FavoriteMealModel> getFavoriteMealById(int favoriteMealId) {
    // TODO: implement getFavoriteMealById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateFavoriteMeal(FavoriteMealModel favoriteMealToUpdate) {
    // TODO: implement updateFavoriteMeal
    throw UnimplementedError();
  }
}
