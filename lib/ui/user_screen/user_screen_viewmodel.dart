import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/home_screen/home_screen.dart';

class UserScreenViewModel extends ChangeNotifier {
  final UserServiceApiClass _userService = getIt<UserServiceApiClass>();

  Future loadData() async {
    // do initialization...
    notifyListeners();
  }

  Future<void> createUser(
      {required String lastname,
      required String firstname,
      required String pseudo,
      required int height,
      required double weight,
      required DateTime birthday,
      required String email,
      required String password,
      required BuildContext context}) async {
    UserModel user = UserModel(
        id: 0,
        firstName: firstname,
        lastName: lastname,
        email: email,
        height: height,
        password: password,
        pseudo: pseudo,
        weight: weight,
        birthday: birthday);
    bool isCreationOk = await _userService.create(user, password);
    if (isCreationOk) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    title: 'Home',
                  )));
    }

    notifyListeners();
  }
}
