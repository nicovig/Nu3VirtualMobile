import 'dart:convert';

class NutritionGoalModel {
  int? id;
  int? order;
  String? name;
  MacronutrientTypeEnum? type;
  DateTime? date;
  int? achievedValue;
  double? achievedRatio;
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

enum MacronutrientTypeEnum { carbohydrate, lipid, protein, calorie }
