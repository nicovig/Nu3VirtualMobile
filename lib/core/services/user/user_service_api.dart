import 'dart:convert';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_response_models.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class UserServiceApi extends UserService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();
  final HttpService _httpService = getIt<HttpService>();
  final UserStore _userStore = getIt<UserStore>();

  static const controllerName = 'User';

  @override
  Future<bool> changePassword(
      int userId, String oldPassword, String newPassword) async {
    var response = await _httpService.patch(
        controllerName,
        'password',
        ['userId', 'oldPassword', 'newPassword'],
        [userId.toString(), oldPassword, newPassword]);
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<bool> create(UserModel userToCreate, String password) async {
    var response = await _httpService.post(
        controllerName, ['password'], [password], userToCreate.toJson());
    if (response.statusCode == 200 || response.statusCode == 204) {
      _saveCreateResponse(response.body);
    }
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<bool> isEmailUsable(String email) async {
    var response =
        await _httpService.get(controllerName, 'email', ['email'], [email]);
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<String> update(UserModel userToUpdate, String password) async {
    var response = await _httpService.put(
        controllerName, ['password'], [password], userToUpdate.toJson());

    if (_httpService.isResponseOk(response.statusCode)) {
      _saveCreateResponse(response.body);
      return "";
    } else {
      if (response.body.contains(
          "Le mot de passe renseigné n'est pas celui qui a servi à la création du compte")) {
        return "Erreur lors de la modification de l'utilisateur, le mot de passe est différent de celui enregistré";
      } else {
        return "Erreur lors de la mise à jour du compte";
      }
    }
  }

  _saveCreateResponse(String tokenModelString) {
    Map<String, dynamic> json = jsonDecode(tokenModelString);
    TokenModelResponse tokenModelResponse = TokenModelResponse.fromJson(json);
    var userModelToString = UserModel.objectToString(tokenModelResponse.user);
    _authenticationStore.saveToken(tokenModelResponse.token);
    _userStore.saveCurrentUser(userModelToString);
  }
}
