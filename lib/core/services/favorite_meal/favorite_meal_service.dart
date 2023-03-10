import 'package:nu3virtual/core/models/favorite_meal_model.dart';

abstract class FavoriteMealService {
  Future<bool> addFavoriteMealToDailyMeals(
      int favoriteMealId, DateTime date, int userId);
  Future<bool> deleteFavoriteMeal(int favoriteMealId);
  Future<List<FavoriteMealModel>> getAllFavoriteMealsByUserId(int userId);
}
