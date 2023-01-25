import 'package:nu3virtual/core/models/workout_model.dart';

abstract class WorkoutService {
  Future<bool> createWorkout(WorkoutModel workout);
  Future<bool> deleteWorkout(int workoutId);
  Future<List<WorkoutModel>> getAllWorkoutsByUserIdAndDate(
      int? userId, DateTime date);
  Future<WorkoutModel> getWorkoutById(int workoutId);
  Future<bool> updateWorkout(WorkoutModel workout);
}
