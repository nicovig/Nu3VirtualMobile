import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_login_response_model.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_reset_password_response.model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class AuthenticationScreenViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final DateStore _dateStore = getIt<DateStore>();

  String login = '';
  String password = '';

  void createAccount(BuildContext context) {
    Navigator.pushNamed(context, modifyUserRoute, arguments: true);
    notifyListeners();
  }

  Future<String> connect(BuildContext context) async {
    login = 'koalaviril';
    password = 'nuvirtual03';
    if (login != '' && password != '') {
      AuthenticationResponse response =
          await _authenticationService.login(login, password);
      if (response.isAuthenticationOk) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
        return '';
      } else {
        return response.error == response.invalidCredentialsResponse()
            ? 'Mauvais login et/ou mot de passe'
            : 'Erreur lors de la connexion';
      }
    }
    notifyListeners();
    return 'Le login et/ou le mot de passe sont vides';
  }

  Future resetPassword(String email) async {
    EasyLoading.show();
    ResetPasswordResponse response =
        await _authenticationService.resetPassword(email);
    EasyLoading.dismiss();
    if (!response.isUserExist) {
      EasyLoading.showError(
          "L'adresse mail renseignée n'est pas ratachée à un compte de l'application");
    }
    if (response.isUserExist &&
        (!response.isEmailSent || !response.isPasswordReset)) {
      EasyLoading.showError(
          "Erreur : veuillez recommencer le processus de réinitialisation du mot de passe");
    }
    if (response.isUserExist &&
        response.isEmailSent &&
        response.isPasswordReset) {
      EasyLoading.showSuccess(
          'Mot de passe modifié avec succès, veuillez regarder dans vos emails');
    }
  }

  void setDate() {
    _dateStore.setDate(DateTime.now());
  }
}
