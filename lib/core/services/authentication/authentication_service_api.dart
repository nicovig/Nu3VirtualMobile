import 'dart:convert';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_login_response_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_reset_password_response.model.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class AuthenticationServiceApi extends AuthenticationService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();
  final HttpService _httpService = getIt<HttpService>();
  final UserStore _userStore = getIt<UserStore>();

  static const controllerName = 'Authentication';

  @override
  Future<AuthenticationResponse> login(String login, String password) async {
    var response = await _httpService.post(
        controllerName, ['login', 'password'], [login, password], null);

    bool isResponseOk = _httpService.isResponseOk(response.statusCode);

    try {
      _saveAuthenticationResponse(response.body);
      return AuthenticationResponse(
          isAuthenticationOk: isResponseOk, error: '');
    } catch (e) {
      return AuthenticationResponse(
          isAuthenticationOk: false, error: response.body);
    }
  }

  @override
  Future<ResetPasswordResponse> resetPassword(String email) async {
    var response =
        await _httpService.get(controllerName, 'email', ['email'], [email]);

    ResetPasswordResponse resetResponse = ResetPasswordResponse(
        isEmailSent: false, isPasswordReset: false, isUserExist: false);

    if (_httpService.isResponseOk(response.statusCode)) {
      final Map<String, dynamic> untypedObject = jsonDecode(response.body);
      resetResponse = ResetPasswordResponse.fromJson(untypedObject);
    }

    return resetResponse;
  }

  _saveAuthenticationResponse(String tokenModelString) {
    Map<String, dynamic> json = jsonDecode(tokenModelString);
    TokenModelResponse tokenModelResponse = TokenModelResponse.fromJson(json);
    var userModelToString = UserModel.objectToString(tokenModelResponse.user);
    _authenticationStore.saveToken(tokenModelResponse.token);
    _userStore.saveCurrentUser(userModelToString);
  }
}
