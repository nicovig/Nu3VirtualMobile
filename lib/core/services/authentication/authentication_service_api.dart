import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_response_models.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';

class AuthenticationServiceApi extends AuthenticationService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();
  final UserStore _userStore = getIt<UserStore>();

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'Authentication';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<AuthenticationResponse> login(String login, String password) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "mail": login,
      "password": password
    };

    var response = await http.post(url, headers: headers);
    try {
      _saveAuthenticationResponse(response.body);
      return AuthenticationResponse(
          isAuthenticationOk:
              response.statusCode == 200 || response.statusCode == 204,
          error: '');
    } catch (e) {
      return AuthenticationResponse(
          isAuthenticationOk: false, error: response.body);
    }
  }

  _saveAuthenticationResponse(String tokenModelString) {
    Map<String, dynamic> json = jsonDecode(tokenModelString);
    TokenModelResponse tokenModelResponse = TokenModelResponse.fromJson(json);
    var userModelToString = UserModel.objectToString(tokenModelResponse.user);
    _authenticationStore.saveToken(tokenModelResponse.token);
    _userStore.saveCurrentUser(userModelToString);
  }
}
