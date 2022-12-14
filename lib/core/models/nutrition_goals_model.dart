import 'dart:convert';

class NutritionGoalsModel {
  int? id;
  int? order;
  String? name;
  DateTime? date;
  int? goalAchievedValue;
  int? goalTotalValue;
  double? goalAchievedRatio;

  NutritionGoalsModel(
      {this.id,
      this.order,
      this.name,
      this.date,
      this.goalAchievedValue,
      this.goalTotalValue,
      this.goalAchievedRatio});

  factory NutritionGoalsModel.fromJson(Map<String, dynamic> parsedJson) {
    return NutritionGoalsModel(
        id: parsedJson['id'] ?? 0,
        order: parsedJson['order'] ?? 0,
        name: parsedJson['name'] ?? "",
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        goalAchievedValue: parsedJson['goalAchievedValue'] ?? 0,
        goalTotalValue: parsedJson['goalTotalValue'] ?? 0,
        goalAchievedRatio: parsedJson['goalAchievedRatio'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'order': order,
      'name': name,
      'date': date?.toIso8601String(),
      'goalAchievedValue': goalAchievedValue,
      'goalTotalValue': goalTotalValue,
      'goalAchievedRatio': goalAchievedRatio
    });
  }
}
