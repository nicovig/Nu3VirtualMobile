import 'dart:convert';

import 'package:nu3virtual/core/models/meal_model.dart';

class FavoriteMealModel {
  int? id;
  String? name;
  MealTypeEnum? type;
  int? carbohydrate;
  int? lipid;
  int? protein;
  int? calorie;
  int? userId;
  int? mealId;

  FavoriteMealModel(
      {this.id,
      this.name,
      this.type,
      this.carbohydrate,
      this.lipid,
      this.protein,
      this.calorie,
      this.userId,
      this.mealId});

  factory FavoriteMealModel.fromJson(Map<String, dynamic> parsedJson) {
    return FavoriteMealModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        type: MealTypeEnum.values[parsedJson['type']],
        carbohydrate: parsedJson['carbohydrate'] ?? "",
        lipid: parsedJson['lipid'] ?? "",
        protein: parsedJson['protein'] ?? "",
        calorie: parsedJson['calorie'] ?? "",
        userId: parsedJson['userId'] ?? 0,
        mealId: parsedJson['mealId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'type': type?.index,
      'carbohydrate': carbohydrate,
      'lipid': lipid,
      'protein': protein,
      'calorie': calorie,
      'userId': userId,
      'mealId': mealId
    });
  }
}
