import 'dart:convert';

class WorkoutModel {
  int? id;
  String? name;
  DateTime? date;
  int? timeInSeconds;
  int? caloriesBurned;
  String? notes;
  int? userId;

  WorkoutModel(
      {this.id,
      this.name,
      this.date,
      this.timeInSeconds,
      this.caloriesBurned,
      this.notes,
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
        notes: parsedJson['notes'] ?? "",
        userId: parsedJson['userId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'date': date?.toIso8601String(),
      'timeInSeconds': timeInSeconds,
      'caloriesBurned': caloriesBurned,
      'notes': notes,
      'userId': userId
    });
  }
}
