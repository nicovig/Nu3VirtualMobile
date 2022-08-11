import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/models/user_model.dart';

class UserServiceStore extends UserServiceStoreClass {
  @override
  Future<UserModel> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(prefs.getString('currentUser') as String);
    UserModel user = UserModel.fromJson(json);
    return user;
  }

  @override
  Future<void> saveCurrentUser(UserModel currentUser) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> decodeOptions = jsonDecode(UserModel().jsonString());
    String user = jsonEncode(UserModel.fromJson(decodeOptions));
    prefs.setString('currentUser', user);
  }
}
