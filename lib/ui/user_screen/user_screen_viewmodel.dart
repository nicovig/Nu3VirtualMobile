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
      required int height,
      required double weight,
      required DateTime birthday,
      required String email,
      required String password}) {
    UserModel user = UserModel(
        id: '0',
        firstName: firstname,
        lastName: lastname,
        email: email,
        height: height.toString(),
        password: password,
        pseudo: pseudo,
        weight: weight.toString(),
        birthday: birthday);
    _userService.create(user, password);
    notifyListeners();
  }
}
