import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/workout_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/workout/workout_service.dart';
import 'package:nu3virtual/service_locator.dart';

class WorkoutServiceApi extends WorkoutService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();

  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'Workout';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<bool> createWorkout(WorkoutModel workout) async {
    var response =
        await http.post(url, headers: headers, body: workout.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<bool> deleteWorkout(int workoutId) async {
    Uri customUrl = Uri.https(hostedDeviceLocalhost + apiUrl,
        '$controllerName/${workoutId.toString()}');
    var response = await http.delete(customUrl, headers: headers);
    return response.statusCode == 200 || response.statusCode == 204;
  }

  @override
  Future<List<WorkoutModel>> getAllWorkoutsByUserIdAndDate(
      int? userId, DateTime date) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "userId": userId.toString(),
      "date": date.toIso8601String()
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    final List untypedObjects = jsonDecode(response.body);
    final List<WorkoutModel> workoutList =
        untypedObjects.map((e) => WorkoutModel.fromJson(e)).toList();

    return workoutList;
  }

  @override
  Future<WorkoutModel> getWorkoutById(int workoutId) async {
    Uri newUrl = Uri.https(
        hostedDeviceLocalhost + apiUrl, '$controllerName/workout/$workoutId');
    var response = await http.get(
      newUrl,
      headers: headers,
    );

    final Map<String, dynamic> untypedObject = jsonDecode(response.body);
    final WorkoutModel workout = WorkoutModel.fromJson(untypedObject);

    return workout;
  }

  @override
  Future<bool> updateWorkout(WorkoutModel workout) async {
    var response =
        await http.put(url, headers: headers, body: workout.toJson());
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
