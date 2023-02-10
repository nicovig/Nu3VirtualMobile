import 'package:flutter/material.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_response_models.dart';
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
    password = 'nuvirtual02';
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
    return 'Le login ou le mot de passe sont vides';
  }

  void setData() {
    _dateStore.setDate(DateTime.now());
  }
}
