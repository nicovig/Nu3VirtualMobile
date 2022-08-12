import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/models/user_model.dart';

class UserServiceStore extends UserStore {
  @override
  Future<UserModel> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(prefs.getString('currentUser') as String);
    UserModel user = UserModel.fromJson(json);
    return user;
  }

  @override
  Future<void> saveCurrentUser(String currentUserString) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUser', currentUserString);
  }
}
