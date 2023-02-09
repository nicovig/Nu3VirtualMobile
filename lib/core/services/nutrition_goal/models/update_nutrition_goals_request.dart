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
  int order;
  int totalValue;

  UpdateNutritionGoalRequest(
      {required this.id, required this.order, required this.totalValue});

  factory UpdateNutritionGoalRequest.fromJson(Map<String, dynamic> parsedJson) {
    return UpdateNutritionGoalRequest(
        id: parsedJson['id'] ?? 0,
        order: parsedJson['order'] ?? 0,
        totalValue: parsedJson['totalValue'] ?? 0);
  }

  String toJson() {
    return jsonEncode({'id': id, 'order': order, 'totalValue': totalValue});
  }
}
