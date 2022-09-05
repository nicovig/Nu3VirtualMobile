import 'package:nu3virtual/core/models/meal_model.dart';

abstract class MealService {
  Future<bool> createMeal(MealModel meal);
  Future<bool> deleteMeal(int mealId);
  Future<bool> deleteMeals(List<int> mealIds);
  Future<List<MealModel>> getAllMealsByUserIdAndDate(
      int? userId, DateTime date);
  Future<bool> updateMeal(MealModel meal);
}
