import 'dart:convert';

class MealModel {
  int? id;
  String? name;
  MealTypeEnum? type;
  bool? isFavorite;
  DateTime? date;
  int? carbohydrate;
  int? lipid;
  int? protein;
  int? calorie;
  String? notes;
  int? userId;

  MealModel(
      {this.id,
      this.name,
      this.type,
      this.isFavorite,
      this.date,
      this.carbohydrate,
      this.lipid,
      this.protein,
      this.calorie,
      this.notes,
      this.userId});

  factory MealModel.fromJson(Map<String, dynamic> parsedJson) {
    return MealModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        type: MealTypeEnum.values[parsedJson['type']],
        isFavorite: parsedJson['isFavorite'] ?? false,
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        carbohydrate: parsedJson['carbohydrate'] ?? "",
        lipid: parsedJson['lipid'] ?? "",
        protein: parsedJson['protein'] ?? "",
        calorie: parsedJson['calorie'] ?? "",
        notes: parsedJson['notes'] ?? "",
        userId: parsedJson['userId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'type': type?.index,
      'isFavorite': isFavorite,
      'date': date?.toIso8601String(),
      'carbohydrate': carbohydrate,
      'lipid': lipid,
      'protein': protein,
      'calorie': calorie,
      'notes': notes,
      'userId': userId
    });
  }
}

enum MealTypeEnum { breakfast, brunch, lunch, snack, dinner }

String getMealTypeEnumText(MealTypeEnum mealType) {
  switch (mealType) {
    case MealTypeEnum.breakfast:
      return 'Petit-déjeuner';

    case MealTypeEnum.brunch:
      return 'Brunch';

    case MealTypeEnum.lunch:
      return 'Déjeuner';

    case MealTypeEnum.snack:
      return 'Collation';

    case MealTypeEnum.dinner:
      return 'Dîner';
    default:
      return 'Collation';
  }
}
