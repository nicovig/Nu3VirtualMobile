import 'package:shared_preferences/shared_preferences.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';

class AuthenticationServiceStore extends AuthenticationStore {
  @override
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') as String;
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', 'Bearer $token');
  }
}
