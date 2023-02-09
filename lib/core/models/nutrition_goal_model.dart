import 'dart:convert';

class NutritionGoalFormModel {
  int? id;
  String? name;
  int? type;
  int? order;
  int? totalValue;

  NutritionGoalFormModel(
      {this.id, this.name, this.type, this.order, this.totalValue});

  factory NutritionGoalFormModel.fromJson(Map<String, dynamic> parsedJson) {
    return NutritionGoalFormModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? '',
        type: parsedJson['type'] ?? 0,
        order: parsedJson['order'] ?? 0,
        totalValue: parsedJson['totalValue'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'type': type,
      'order': order,
      'totalValue': totalValue
    });
  }
}

class NutritionGoalDisplayedModel {
  int? id;
  int? order;
  String? name;
  int? type;
  DateTime? date;
  int? achievedValue;
  num? achievedRatio;
  int? totalValue;

  NutritionGoalDisplayedModel(
      {this.id,
      this.order,
      this.name,
      this.type,
      this.date,
      this.achievedValue,
      this.totalValue,
      this.achievedRatio});

  factory NutritionGoalDisplayedModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return NutritionGoalDisplayedModel(
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
