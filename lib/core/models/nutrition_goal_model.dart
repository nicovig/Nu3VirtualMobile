import 'dart:convert';

class NutritionGoalDisplayedModel {
  int? id;
  int? order;
  String? name;
  int? type;
  DateTime? date;
  int? achievedValue;
  num? achievedRatio;
  int? totalValue;
  bool isActive;

  NutritionGoalDisplayedModel(
      {this.id,
      this.order,
      this.name,
      this.type,
      this.date,
      this.achievedValue,
      this.totalValue,
      this.achievedRatio,
      required this.isActive});

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
        achievedRatio: parsedJson['achievedRatio'] ?? 0,
        isActive: parsedJson['isActive'] ?? true);
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
      'achievedRatio': achievedRatio,
      'isActive': isActive
    });
  }
}

enum MacronutrientTypeEnum { carbohydrate, lipid, protein, calorie }

String getMacronutrientTypeEnumText(MacronutrientTypeEnum macronutrientType) {
  switch (macronutrientType) {
    case MacronutrientTypeEnum.carbohydrate:
      return 'Glucides';

    case MacronutrientTypeEnum.lipid:
      return 'Lipides';

    case MacronutrientTypeEnum.protein:
      return 'Protéines';

    case MacronutrientTypeEnum.calorie:
      return 'Calories';

    default:
      return 'Calories';
  }
}
