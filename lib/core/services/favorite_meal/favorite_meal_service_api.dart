import 'dart:convert';

import 'package:nu3virtual/core/models/favorite_meal_model.dart';
import 'package:nu3virtual/core/services/favorite_meal/favorite_meal_service.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/service_locator.dart';

class FavoriteMealServiceApi extends FavoriteMealService {
  final HttpService _httpService = getIt<HttpService>();

  static const controllerName = 'FavoriteMeal';

  @override
  Future<bool> addFavoriteMealToDailyMeals(
      int favoriteMealId, DateTime date, int userId) async {
    var response = await _httpService.post(
        controllerName,
        ['userId'],
        [userId.toString()],
        jsonEncode({
          'date': date.toIso8601String(),
          'favoriteMealId': favoriteMealId
        }));
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteFavoriteMeal(int favoriteMealId) async {
    var response = await _httpService.delete(controllerName, favoriteMealId);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<FavoriteMealModel>> getAllFavoriteMealsByUserId(
      int userId) async {
    var response =
        await _httpService.get(controllerName, ['userId'], [userId.toString()]);

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
