// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

String getMonitoringDate(DateTime date) {
  return 'Semaine ${_getWeekNumber(date)} - ${DateFormat('EEEE d MMMM yyyy').format(date)}';
}

num _getWeekNumber(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1, 0, 0);
  final firstMonday = startOfYear.weekday;
  final daysInFirstWeek = 8 - firstMonday;
  final diff = date.difference(startOfYear);
  var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
// It might differ how you want to treat the first week
  if (daysInFirstWeek > 3) {
    weeks += 1;
  }
  return weeks;
}
