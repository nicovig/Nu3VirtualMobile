import 'package:flutter/widgets.dart';

import 'package:event/event.dart';

import 'package:nu3virtual/core/const/routes.dart';
import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/date/date_service_class.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';

class WorkoutTabViewModel extends ChangeNotifier {
  final DateStore _dateStore = getIt<DateStore>();
  final UserStore _userStore = getIt<UserStore>();
  final WorkoutService _workoutService = getIt<WorkoutService>();

  List<WorkoutModel> workouts = [];
  int? userId = 0;

  Future initData(Event<EventArgs> dateChangeEvent) async {
    _dateChangeSubscribe(dateChangeEvent);
    UserModel user = await _userStore.getCurrentUser();
    userId = user.id ?? 0;
    await loadData();
    notifyListeners();
  }

  openWorkoutScreen(BuildContext context, int workoutId) {
    Navigator.pushNamed(
      context,
      workoutRoute,
      arguments: workoutId,
    );
  }

  Future deleteWorkout(int workoutId, BuildContext dialogContext) async {
    bool isDeleteOk = await _workoutService.deleteWorkout(workoutId);
    Navigator.of(dialogContext).pop(isDeleteOk);
    notifyListeners();
  }

  Future loadData() async {
    DateTime currentDate = await _dateStore.getDate();
    await _getWorkouts(currentDate);
    notifyListeners();
  }

  void _dateChangeSubscribe(Event<EventArgs> dateChangeEvent) {
    dateChangeEvent.subscribe((args) async {
      await loadData();
    });
  }

  Future _getWorkouts(DateTime date) async {
    workouts =
        await _workoutService.getAllWorkoutsByUserIdAndDate(userId, date);
    notifyListeners();
  }
}
