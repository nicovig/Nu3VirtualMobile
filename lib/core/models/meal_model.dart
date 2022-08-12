import 'dart:convert';

import 'package:nu3virtual/core/models/user_model.dart';

class MealModel {
  int? id;
  String? name;
  DateTime? date;
  int? carbohydrate;
  int? lipid;
  int? protein;
  int? calorie;
  UserModel? user;

  MealModel(
      {this.id,
      this.name,
      this.date,
      this.carbohydrate,
      this.lipid,
      this.protein,
      this.calorie,
      this.user});

  factory MealModel.fromJson(Map<String, dynamic> parsedJson) {
    return MealModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        date: parsedJson['date'] ?? "",
        carbohydrate: parsedJson['carbohydrate'] ?? "",
        lipid: parsedJson['lipid'] ?? "",
        protein: parsedJson['protein'] ?? "",
        calorie: parsedJson['calorie'] ?? "",
        user: UserModel.fromJson(parsedJson['user']));
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'date': date,
      'carbohydrate': carbohydrate,
      'lipid': lipid,
      'protein': protein,
      'calorie': calorie,
      'user': user
    });
  }
}
