import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nu3virtual/ui/user_screen/user_screen.dart';

class AuthenticationScreenViewModel extends ChangeNotifier {
  int _someValue = 0;
  int get someValue => _someValue;
  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

  void createAccount(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => UserScreen()));
    notifyListeners();
  }

  void login() {
    // do something...
    notifyListeners();
  }
}
