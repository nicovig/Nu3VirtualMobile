import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class UserService extends UserServiceApiClass {
  final UserServiceStoreClass _userServiceStore =
      getIt<UserServiceStoreClass>();

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost = '10.0.2.2:';
  static const apiUrl = '44383';
  static const controllerName = 'User';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<bool> create(UserModel userToCreate, String password) async {
    var response =
        await http.post(url, headers: headers, body: userToCreate.toJson());
    _userServiceStore.saveCurrentUser(response.body);
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
