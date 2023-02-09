import 'package:flutter/material.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class UserScreenViewModel extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  final UserStore _userStore = getIt<UserStore>();

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

  Future<bool> validate(
      BuildContext context, UserModel user, bool isFromLogin) async {
    bool isOk = false;

    if (isFromLogin) {
      var passwordSended = user.password ?? '';
      user.password = '';
      isOk = await _userService.create(user, passwordSended);
    } else {
      isOk = await _userService.update(user);
    }

    if (isOk) {
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
          arguments: isFromLogin ? null : MainScreenTabEnum.informations.index);
      return true;
    } else {
      return false;
    }
  }
}
