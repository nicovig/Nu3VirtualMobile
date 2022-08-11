import 'package:flutter/material.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/user_screen/user_screen.dart';

class AuthenticationScreenViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  late String login;
  late String password;

  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

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

  void connect() {
    if (login != '' && password != '') {
      _authenticationService.login(login, password);
    }

    notifyListeners();
  }
}
