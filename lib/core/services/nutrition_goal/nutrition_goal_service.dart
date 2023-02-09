import 'package:nu3virtual/core/models/nutrition_goal_model.dart';
import 'package:nu3virtual/core/services/nutrition_goal/models/update_nutrition_goals_request.dart';

abstract class NutritionGoalService {
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserId(
      int? userId);
  Future<List<NutritionGoalDisplayedModel>> getAllNutritionGoalsByUserIdAndDate(
      int? userId, DateTime date);
  Future<bool> updateNutritionGoals(
      UpdateNutritionGoalsRequest updatedNutritionGoal);
}
