import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class UserScreenViewModel extends ChangeNotifier {
  final UserServiceApiClass _userService = getIt<UserServiceApiClass>();

  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

  void createUser(
      {required String lastname,
      required String firstname,
      required String pseudo,
      required String height,
      required String weight,
      required String email,
      required String phone,
      required String password}) {
    UserModel user = UserModel(
        id: '0',
        firstName: firstname,
        lastName: lastname,
        email: email,
        height: height,
        password: password,
        pseudo: pseudo,
        weight: weight,
        birthday: DateTime.now().toString());

    _userService.create(user, password);
    // do something...
    notifyListeners();
  }
}
