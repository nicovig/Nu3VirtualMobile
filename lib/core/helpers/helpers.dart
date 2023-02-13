// ignore: depend_on_referenced_packages
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:nu3virtual/core/models/meal_model.dart';

MealTypeEnum getDefaultMealType() {
  var test = TimeOfDay.now().hour;
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

String getMonitoringDate(DateTime date, context) {
  return 'Semaine ${_getWeekNumber(date)} - ${DateFormat('EEEE d MMMM yyyy').format(date)}'; //mecredi 30 novembre 2022
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
