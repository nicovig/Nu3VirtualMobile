import 'package:flutter/material.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class UserScreenViewModel extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  final UserStore _userStore = getIt<UserStore>();

  Future<void> createUser(
      BuildContext context, UserModel user, bool isFromLogin) async {
    bool isCreationOk = await _userService.create(user, user.password ?? '');
    if (isCreationOk && isFromLogin) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(homeRoute, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
          arguments: MainScreenTabEnum.informations.index);
    }
    notifyListeners();
  }

  Future<UserModel> loadData() async {
    UserModel user = await _userStore.getCurrentUser();
    if (user.id != 0) {
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
    } else {
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
    }
  }
}
