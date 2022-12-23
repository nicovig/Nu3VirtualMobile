import 'package:flutter/widgets.dart';

import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';

class WorkoutTabViewModel extends ChangeNotifier {
  final MonitoringService _monitoringService = getIt<MonitoringService>();
  final UserStore _userStore = getIt<UserStore>();
  final WorkoutService _workoutService = getIt<WorkoutService>();

  List<WorkoutModel> workouts = [];
  MonitoringModel monitoringDisplayed = MonitoringModel();
  int? userId = 0;

  Future initData(DateTime date) async {
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await loadData(date);
    notifyListeners();
  }

  Future addWorkout(WorkoutModel workout, BuildContext dialogContext) async {
    bool isCreateOk = await _workoutService.createWorkout(workout);
    Navigator.pop(dialogContext, isCreateOk);
    notifyListeners();
  }

  Future deleteWorkout(int workoutId, BuildContext dialogContext) async {
    bool isDeleteOk = await _workoutService.deleteWorkout(workoutId);
    Navigator.of(dialogContext).pop(isDeleteOk);
    notifyListeners();
  }

  Future loadData(DateTime date) async {
    await _getWorkouts(date);
    await _getMonitoring(date);
    notifyListeners();
  }

  Future updateWorkout(WorkoutModel workout, BuildContext dialogContext) async {
    bool isUpdateOk = await _workoutService.updateWorkout(workout);
    Navigator.pop(dialogContext, isUpdateOk);
    notifyListeners();
  }

  Future _getMonitoring(DateTime date) async {
    monitoringDisplayed =
        await _monitoringService.getMonitoringByUserIdAndDate(userId, date);
    notifyListeners();
  }

  Future _getWorkouts(DateTime date) async {
    workouts =
        await _workoutService.getAllWorkoutsByUserIdAndDate(userId, date);
    notifyListeners();
  }
}
