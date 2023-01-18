import 'dart:convert';

class NutritionGoalModel {
  int? id;
  int? order;
  String? name;
  int? type;
  DateTime? date;
  int? achievedValue;
  num? achievedRatio;
  int? totalValue;

  NutritionGoalModel(
      {this.id,
      this.order,
      this.name,
      this.type,
      this.date,
      this.achievedValue,
      this.totalValue,
      this.achievedRatio});

  factory NutritionGoalModel.fromJson(Map<String, dynamic> parsedJson) {
    return NutritionGoalModel(
        id: parsedJson['id'] ?? 0,
        order: parsedJson['order'] ?? 0,
        name: parsedJson['name'] ?? "",
        type: parsedJson['type'] ?? 0,
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        achievedValue: parsedJson['achievedValue'] ?? 0,
        totalValue: parsedJson['totalValue'] ?? 0,
        achievedRatio: parsedJson['achievedRatio'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'order': order,
      'name': name,
      'type': type,
      'date': date?.toIso8601String(),
      'achievedValue': achievedValue,
      'totalValue': totalValue,
      'achievedRatio': achievedRatio
    });
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

enum MacronutrientTypeEnum { carbohydrate, lipid, protein, calorie }
