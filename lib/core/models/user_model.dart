import 'dart:convert';

class UserModel {
  String? id;
  String? pseudo;
  String? firstName;
  String? lastName;
  DateTime? birthday;
  String? height;
  String? weight;
  String? email;
  String? password;

  UserModel(
      {this.id,
      this.pseudo,
      this.firstName,
      this.lastName,
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
        birthday: parsedJson['birthday'] ?? "",
        height: parsedJson['height'] ?? "",
        weight: parsedJson['weight'] ?? "",
        email: parsedJson['email'] ?? "",
        password: parsedJson['password'] ?? "");
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'pseudo': pseudo,
      'firstName': firstName,
      'lastName': lastName,
      'birthday': birthday?.toIso8601String(),
      'height': height,
      'weight': weight,
      'email': email,
      'password': password
    });
  }

  String jsonString() {
    return '{"id": 0, "pseudo": "", "firstName": "", "lastName": "", "birthday": null, "height": 0, "weight": 0, "email": "", "password": ""}';
  }
}
