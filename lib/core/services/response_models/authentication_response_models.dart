import 'dart:convert';

import 'package:nu3virtual/core/models/user_model.dart';

class TokenModelResponse {
  UserModel user;
  String token;

  TokenModelResponse({required this.user, required this.token});

  factory TokenModelResponse.fromJson(Map<String, dynamic> parsedJson) {
    return TokenModelResponse(
        user: UserModel.fromJson(parsedJson['user']),
        token: parsedJson['token'] ?? '');
  }

  String toJson() {
    return jsonEncode({'user': user, 'token': token});
  }

  String jsonString() {
    return '{"user": {}, "token": ""}';
  }
}
