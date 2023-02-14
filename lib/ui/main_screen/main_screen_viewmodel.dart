import 'package:event/event.dart';
import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/layouts/screen_layouts/change_date_buttons.dart';
import 'package:nu3virtual/service_locator.dart';

class MainScreenViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final MonitoringService _monitoringService = getIt<MonitoringService>();
  final UserStore _userStore = getIt<UserStore>();

  Event<EventArgs> dateChangeEvent = Event();
  DateTime date = DateTime.now();
  MonitoringModel monitoringDisplayed = MonitoringModel();
  UserModel user = UserModel();

  Future loadData() async {
    user = await _userStore.getCurrentUser();
    date = await _dateStore.getDate();
    await _getMonitoring();
    notifyListeners();
  }

  void disconnect(BuildContext context) async {
    await _userStore.deleteCurrentUser();
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
  }

  void updateDate(ChangeDateButtonTypeEnum dateChangeType) async {
    switch (dateChangeType) {
      case ChangeDateButtonTypeEnum.left:
        date = DateTime(date.year, date.month, date.day - 1);
        break;
      case ChangeDateButtonTypeEnum.middle:
        date = DateTime.now();
        break;
      case ChangeDateButtonTypeEnum.right:
        date = DateTime(date.year, date.month, date.day + 1);
        break;
    }
    _dateStore.setDate(date);
    await _getMonitoring();
    dateChangeEvent.broadcast();
  }

  Future _getMonitoring() async {
    monitoringDisplayed =
        await _monitoringService.getMonitoringByUserIdAndDate(user.id, date);
    notifyListeners();
  }
}
