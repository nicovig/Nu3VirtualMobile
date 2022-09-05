import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final UserStore _userStore = getIt<UserStore>();

  late UserModel user = UserModel();

  Future loadData() async {
    user = await _userStore.getCurrentUser();
    notifyListeners();
  }

  void disconnect(BuildContext context) async {
    await _userStore.deleteCurrentUser();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }
}
