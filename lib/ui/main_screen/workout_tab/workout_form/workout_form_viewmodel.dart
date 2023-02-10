import 'dart:async';

import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';
import 'package:nu3virtual/ui/main_screen/main_screen.dart';

class WorkoutFormViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final UserStore _userStore = getIt<UserStore>();
  final WorkoutService _workoutService = getIt<WorkoutService>();

  late UserModel user = UserModel();
  late WorkoutModel workout = WorkoutModel();

  int minutes = 0;
  int seconds = 0;

  getMinutes(int? timeInSeconds) {
    if (timeInSeconds != null) {
      var result = (timeInSeconds / 60).round();
      minutes = result;
      return result.toString();
    }
    return 0;
  }

  getSeconds(int? timeInSeconds) {
    if (timeInSeconds != null) {
      var result = timeInSeconds % 60;
      seconds = result;
      return result.toString();
    }
    return 0;
  }

  handleValidation(BuildContext context) async {
    workout.timeInSeconds = (minutes * 60) + seconds;
    workout.userId = user.id;
    workout.id == 0
        ? await _addWorkout(context)
        : await _updateWorkout(context);
  }

  Future<WorkoutModel> loadData(int workoutId) async {
    user = await _userStore.getCurrentUser();
    if (workoutId != 0) {
      return Future<WorkoutModel>.delayed(const Duration(seconds: 1),
          () => _workoutService.getWorkoutById(workoutId));
    } else {
      DateTime currentDate = await _dateStore.getDate();
      return Future<WorkoutModel>.delayed(
          const Duration(seconds: 0),
          () => WorkoutModel(
              id: 0,
              name: '',
              date: DateTime(
                  currentDate.year, currentDate.month, currentDate.day),
              timeInSeconds: 0,
              caloriesBurned: 0,
              notes: '',
              userId: user.id));
    }
  }

  Future _addWorkout(BuildContext context) async {
    bool isUpdateOk = await _workoutService.createWorkout(workout);
    if (isUpdateOk) {
      _redirectToWorkoutTab(context);
    }
    notifyListeners();
  }

  Future _updateWorkout(BuildContext context) async {
    bool isUpdateOk = await _workoutService.updateWorkout(workout);
    if (isUpdateOk) {
      _redirectToWorkoutTab(context);
    }
    notifyListeners();
  }

  _redirectToWorkoutTab(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false,
        arguments: MainScreenTabEnum.workouts.index);
  }
}
