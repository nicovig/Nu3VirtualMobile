import 'dart:convert';

class UpdateNutritionGoalsRequest {
  List<UpdateNutritionGoalRequest> nutritionGoals;

  UpdateNutritionGoalsRequest({required this.nutritionGoals});

  String toJson() {
    var returnValue = jsonEncode({'nutritionGoals': nutritionGoals});
    returnValue = returnValue.replaceAll('\\', '');
    returnValue = returnValue.replaceAll('"{', '{');
    return returnValue.replaceAll('}"', '}');
  }
}

class UpdateNutritionGoalRequest {
  int id;
  int totalValue;
  bool isActive;

  UpdateNutritionGoalRequest(
      {required this.id, required this.totalValue, required this.isActive});

  factory UpdateNutritionGoalRequest.fromJson(Map<String, dynamic> parsedJson) {
    return UpdateNutritionGoalRequest(
        id: parsedJson['id'] ?? 0,
        totalValue: parsedJson['totalValue'] ?? 0,
        isActive: parsedJson['isActive'] ?? true);
  }

  String toJson() {
    return jsonEncode(
        {'id': id, 'totalValue': totalValue, 'isActive': isActive});
  }
}
