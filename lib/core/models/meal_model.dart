import 'dart:convert';

class MealModel {
  int? id;
  String? name;
  DateTime? date;
  int? carbohydrate;
  int? lipid;
  int? protein;
  int? calorie;
  int? userId;

  MealModel(
      {this.id,
      this.name,
      this.date,
      this.carbohydrate,
      this.lipid,
      this.protein,
      this.calorie,
      this.userId});

  factory MealModel.fromJson(Map<String, dynamic> parsedJson) {
    return MealModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        carbohydrate: parsedJson['carbohydrate'] ?? "",
        lipid: parsedJson['lipid'] ?? "",
        protein: parsedJson['protein'] ?? "",
        calorie: parsedJson['calorie'] ?? "",
        userId: parsedJson['userId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'date': date?.toIso8601String(),
      'carbohydrate': carbohydrate,
      'lipid': lipid,
      'protein': protein,
      'calorie': calorie,
      'userId': userId
    });
  }
}
