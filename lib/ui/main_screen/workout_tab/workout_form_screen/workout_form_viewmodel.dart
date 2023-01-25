import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nu3virtual/core/const/routes.dart';

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';

class WorkoutFormViewModel extends ChangeNotifier {
  final UserStore _userStore = getIt<UserStore>();
  final WorkoutService _workoutService = getIt<WorkoutService>();

  late UserModel user = UserModel();
  late WorkoutModel workout = WorkoutModel();

  int minutes = 0;
  int seconds = 0;

  getTimeInSeconds() {}

  getSeconds() {}

  getTimeMinutes() {}

  handleValidation(BuildContext context) async {
    workout.timeInSeconds = getTimeInSeconds();

    workout.id == null
        ? await _addWorkout(context)
        : await _updateWorkout(context);
  }

  Future<WorkoutModel> loadData(int workoutId) async {
    user = await _userStore.getCurrentUser();
    if (workoutId != 0) {
      return Future<WorkoutModel>.delayed(const Duration(seconds: 1),
          () => _workoutService.getWorkoutById(workoutId));
    } else {
      return Future<WorkoutModel>.delayed(
          const Duration(seconds: 1),
          () => WorkoutModel(
              id: 0,
              name: '',
              date: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  TimeOfDay.now().hour,
                  TimeOfDay.now().minute),
              timeInSeconds: 0,
              caloriesBurned: 0,
              userId: user.id));
    }
  }

  Future _addWorkout(BuildContext context) async {
    workout.id = 0;
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
    Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
  }
}
