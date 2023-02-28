import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class UserScreenViewModel extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  final UserStore _userStore = getIt<UserStore>();

  String initialEmail = '';
  String firstPassword = '';
  String secondPassword = '';

  Future<UserModel> loadData(bool isFromLogin) async {
    if (isFromLogin) {
      return Future<UserModel>.delayed(
          const Duration(seconds: 0),
          () => UserModel(
              id: 0,
              pseudo: '',
              firstName: '',
              lastName: '',
              gender: GenderEnum.male.index,
              birthday: DateTime.now(),
              height: 0,
              weight: 0,
              email: '',
              password: ''));
    } else {
      UserModel user = await _userStore.getCurrentUser();
      initialEmail = user.email ?? '';
      return Future<UserModel>.delayed(
          const Duration(seconds: 0),
          () => UserModel(
              id: user.id,
              pseudo: user.pseudo,
              firstName: user.firstName,
              lastName: user.lastName,
              gender: user.gender,
              birthday: user.birthday,
              height: user.height,
              weight: user.weight,
              email: user.email,
              password: user.password));
    }
  }

  Future<String> validate(BuildContext context, UserModel user, String password,
      bool isCreatingUser) async {
    String message = '';
    bool isEmailUsable = true;
    bool isOk = false;

    if (isCreatingUser || initialEmail != user.email) {
      isEmailUsable = await _userService.isEmailUsable(user.email ?? '');
    }

    if (isEmailUsable) {
      if (isCreatingUser) {
        isOk = await _userService.create(user, password);
      } else {
        message = await _userService.update(user, password);
        isOk = message == "" ? true : false;
      }
    } else {
      message = "L'email renseigné est déjà pris par un compte";
    }

    if (isOk) {
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
          arguments:
              isCreatingUser ? null : MainScreenTabEnum.informations.index);
      return message;
    } else {
      return message;
    }
  }
}
