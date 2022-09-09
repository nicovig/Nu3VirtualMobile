import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/service_locator.dart';

class MainScreenViewModel extends ChangeNotifier {
  final UserStore _userStore = getIt<UserStore>();

  StreamController<DateTime> streamController = StreamController.broadcast();

  late UserModel user = UserModel();
  late DateTime date = DateTime.now();

  Future loadData() async {
    streamController.stream.listen((event) {
      date = event;
    });

    user = await _userStore.getCurrentUser();
    notifyListeners();
  }

  void addOneDayOnDate() {
    streamController.add((DateTime(date.year, date.month, date.day + 1)));
  }

  void disconnect(BuildContext context) async {
    await _userStore.deleteCurrentUser();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  void minusOneDayOnDate() {
    streamController.add((DateTime(date.year, date.month, date.day - 1)));
  }

  void todayOnDate() {
    streamController.add((DateTime.now()));
  }
}
