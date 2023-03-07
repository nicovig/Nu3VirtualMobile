import 'dart:convert';

import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';

class WorkoutServiceApi extends WorkoutService {
  final HttpService _httpService = getIt<HttpService>();

  static const controllerName = 'Workout';

  @override
  Future<bool> createWorkout(WorkoutModel workout) async {
    var response =
        await _httpService.post(controllerName, [], [], workout.toJson());
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<bool> deleteWorkout(int workoutId) async {
    var response = await _httpService.delete(controllerName, workoutId);
    return _httpService.isResponseOk(response.statusCode);
  }

  @override
  Future<List<WorkoutModel>> getAllWorkoutsByUserIdAndDate(
      int? userId, DateTime date) async {
    List<WorkoutModel> workoutList = [];
    var response = await _httpService.get(controllerName, null,
        ['userId', 'date'], [userId.toString(), date.toIso8601String()]);

    if (_httpService.isResponseOk(response.statusCode)) {
      final List untypedObjects = jsonDecode(response.body);
      workoutList =
          untypedObjects.map((e) => WorkoutModel.fromJson(e)).toList();
    }
    return workoutList;
  }

  @override
  Future<WorkoutModel> getWorkoutById(int workoutId) async {
    WorkoutModel workout = WorkoutModel();
    var response =
        await _httpService.get(controllerName, 'workout/$workoutId', [], []);

    if (_httpService.isResponseOk(response.statusCode)) {
      final Map<String, dynamic> untypedObject = jsonDecode(response.body);
      workout = WorkoutModel.fromJson(untypedObject);
    }
    return workout;
  }

  @override
  Future<bool> updateWorkout(WorkoutModel workout) async {
    var response =
        await _httpService.put(controllerName, [], [], workout.toJson());
    return _httpService.isResponseOk(response.statusCode);
  }
}
