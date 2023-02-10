import 'package:shared_preferences/shared_preferences.dart';

import 'package:nu3virtual/core/services/date/date_service_class.dart';

class DateServiceStore extends DateStore {
  @override
  Future<DateTime> getDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var day = prefs.getInt('day');
    var month = prefs.getInt('month');
    var year = prefs.getInt('year');
    return DateTime(year ?? DateTime.now().year, month ?? DateTime.now().year,
        day ?? DateTime.now().day);
  }

  @override
  Future<void> setDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('day', date.day);
    prefs.setInt('month', date.month);
    prefs.setInt('year', date.year);
  }
}
