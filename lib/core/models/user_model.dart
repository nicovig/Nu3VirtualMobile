import 'dart:convert';

import 'package:nu3virtual/core/helpers/helpers.dart';

class UserModel {
  int? id;
  String? pseudo;
  String? firstName;
  String? lastName;
  int? gender;
  DateTime? birthday;
  int? height;
  num? weight;
  String? email;
  String? password;

  UserModel(
      {this.id,
      this.pseudo,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthday,
      this.height,
      this.weight,
      this.email,
      this.password});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        id: parsedJson['id'] ?? 0,
        pseudo: parsedJson['pseudo'] ?? "",
        firstName: parsedJson['firstName'] ?? "",
        lastName: parsedJson['lastName'] ?? "",
        gender: parsedJson['gender'] ?? 0,
        height: parsedJson['height'] ?? 0,
        weight: parsedJson['weight'] ?? 0,
        email: parsedJson['email'] ?? "",
        password: parsedJson['password'] ?? "",
        birthday: parsedJson['birthday'] != null
            ? DateTime.parse(parsedJson['birthday'])
            : null);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'pseudo': pseudo,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthday': birthday?.toIso8601String(),
      'height': height,
      'weight': weight,
      'email': email,
      'password': password
    });
  }

  static String objectToString(UserModel user) {
    return '{"id": ${user.id}, "pseudo": "${user.pseudo}", "firstName": "${user.firstName}", "lastName": "${user.lastName}", "gender": ${user.gender} ,"birthday": "${user.birthday}", "height": ${user.height}, "weight": ${user.weight}, "email": "${user.email}", "password": "${user.password}"}';
  }

  String jsonString() {
    return '{"id": 0, "pseudo": "", "firstName": "", "lastName": "", "gender": 0, "birthday": null, "height": 0, "weight": 0, "email": "", "password": ""}';
  }
}

enum GenderEnum { unknown, male, female, other }
