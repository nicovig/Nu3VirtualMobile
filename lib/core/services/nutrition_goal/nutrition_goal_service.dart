import 'package:nu3virtual/core/models/nutrition_goal_model.dart';

abstract class NutritionGoalService {
  Future<List<NutritionGoalModel>> getAllNutritionGoalsByUserIdAndDate(
      int? userId, DateTime date);
  Future<bool> updateNutritionGoal(
      UpdateNutritionGoalRequest updatedNutritionGoal);
}
