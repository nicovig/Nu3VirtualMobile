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
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteWorkout(int workoutId) async {
    var response = await _httpService.delete(controllerName, workoutId);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<WorkoutModel>> getAllWorkoutsByUserIdAndDate(
      int? userId, DateTime date) async {
    var response = await _httpService.get(controllerName, null,
        ['userId', 'date'], [userId.toString(), date.toIso8601String()]);
    final List untypedObjects = jsonDecode(response.body);
    final List<WorkoutModel> workoutList =
        untypedObjects.map((e) => WorkoutModel.fromJson(e)).toList();
    return workoutList;
  }

  @override
  Future<WorkoutModel> getWorkoutById(int workoutId) async {
    var response =
        await _httpService.get(controllerName, 'workout/$workoutId', [], []);
    final Map<String, dynamic> untypedObject = jsonDecode(response.body);
    final WorkoutModel workout = WorkoutModel.fromJson(untypedObject);
    return workout;
  }

  @override
  Future<bool> updateWorkout(WorkoutModel workout) async {
    var response =
        await _httpService.put(controllerName, [], [], workout.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
