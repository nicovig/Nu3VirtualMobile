import 'dart:convert';
import 'dart:developer';

class UserModel {
  int? id;
  String? pseudo;
  String? firstName;
  String? lastName;
  DateTime? birthday;
  int? height;
  double? weight;
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
    var birthdayFromJSON = DateTime.parse(parsedJson['birthday']);
    log(birthdayFromJSON.toString());
    return UserModel(
        id: parsedJson['id'] ?? 0,
        pseudo: parsedJson['pseudo'] ?? "",
        firstName: parsedJson['firstName'] ?? "",
        lastName: parsedJson['lastName'] ?? "",
        height: parsedJson['height'] ?? "",
        weight: parsedJson['weight'] ?? "",
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
      'birthday': birthday?.toIso8601String(),
      'height': height,
      'weight': weight,
      'email': email,
      'password': password
    });
  }

  static String objectToString(UserModel user) {
    return '{"id": ${user.id}, "pseudo": "${user.pseudo}", "firstName": "${user.firstName}", "lastName": "${user.lastName}", "birthday": "${user.birthday}", "height": ${user.height}, "weight": ${user.weight}, "email": "${user.email}", "password": "${user.password}"}';
  }

  String jsonString() {
    return '{"id": 0, "pseudo": "", "firstName": "", "lastName": "", "birthday": null, "height": 0, "weight": 0, "email": "", "password": ""}';
  }
}
