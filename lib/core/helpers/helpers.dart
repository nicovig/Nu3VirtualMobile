// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:nu3virtual/core/models/meal_model.dart';

MealTypeEnum getDefaultMealType() {
  if (TimeOfDay.now().hour <= 10) {
    return MealTypeEnum.breakfast;
  }
  if (TimeOfDay.now().hour < 12) {
    return MealTypeEnum.brunch;
  }
  if (TimeOfDay.now().hour <= 14) {
    return MealTypeEnum.lunch;
  }
  if (TimeOfDay.now().hour <= 18) {
    return MealTypeEnum.snack;
  }
  return MealTypeEnum.dinner;
}

int getMinutesWithTimeInSeconds(int? timeInSeconds) {
  if (timeInSeconds != null) {
    return (timeInSeconds / 60).round();
  }
  return 0;
}

String getMonitoringDate(DateTime date, context) {
  return DateFormat('EEEE d MMMM yyyy').format(date); //mecredi 30 novembre 2022
}

int getSecondsRemains(int? timeInSeconds) {
  if (timeInSeconds != null) {
    return timeInSeconds % 60;
  }
  return 0;
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
