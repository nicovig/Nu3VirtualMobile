import 'dart:convert';

class WorkoutModel {
  int? id;
  String? name;
  DateTime? date;
  int? timeInSeconds;
  int? caloriesBurned;
  int? userId;

  WorkoutModel(
      {this.id,
      this.name,
      this.date,
      this.timeInSeconds,
      this.caloriesBurned,
      this.userId});

  factory WorkoutModel.fromJson(Map<String, dynamic> parsedJson) {
    return WorkoutModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        timeInSeconds: parsedJson['timeInSeconds'] ?? "",
        caloriesBurned: parsedJson['caloriesBurned'] ?? "",
        userId: parsedJson['userId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'date': date?.toIso8601String(),
      'timeInSeconds': timeInSeconds,
      'caloriesBurned': caloriesBurned,
      'userId': userId
    });
  }
}
