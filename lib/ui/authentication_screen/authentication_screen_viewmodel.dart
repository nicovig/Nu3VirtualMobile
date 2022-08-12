import 'package:flutter/material.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/home_screen/home_screen.dart';
import 'package:nu3virtual/ui/user_screen/user_screen.dart';

class AuthenticationScreenViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  String login = '';
  String password = '';

  checkEmailOrPseudo(String input) {
    login = input;
  }

  checkPassword(String input) {
    password = input;
  }

  void createAccount(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserScreen()));
    notifyListeners();
  }

  void connect(BuildContext context) async {
    if (login != '' && password != '') {
      bool isLoginOk = await _authenticationService.login(login, password);
      if (isLoginOk)
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
    }

    notifyListeners();
  }
}
