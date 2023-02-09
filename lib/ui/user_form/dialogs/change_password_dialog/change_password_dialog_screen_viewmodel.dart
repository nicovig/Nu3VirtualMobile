import 'package:flutter/material.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class ChangePasswordDialogScreenViewModel extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  final UserStore _userStore = getIt<UserStore>();

  int userId = 0;
  String oldPassword = '';
  String firstNewPassword = '';
  String secondNewPassword = '';

  Future<void> loadData() async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    notifyListeners();
  }

  Future<bool> changePassword(BuildContext context) async {
    return await _userService.changePassword(
        userId, oldPassword, firstNewPassword);
  }

  closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
