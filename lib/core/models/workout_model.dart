import 'dart:convert';

class WorkoutModel {
  int? id;
  String? label;
  DateTime? date;
  int? timeInSeconds;
  int? caloriesConsumed;
  int? userId;

  WorkoutModel(
      {this.id,
      this.label,
      this.date,
      this.timeInSeconds,
      this.caloriesConsumed,
      this.userId});

  factory WorkoutModel.fromJson(Map<String, dynamic> parsedJson) {
    return WorkoutModel(
        id: parsedJson['id'] ?? 0,
        label: parsedJson['label'] ?? "",
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        timeInSeconds: parsedJson['timeInSeconds'] ?? "",
        caloriesConsumed: parsedJson['caloriesConsumed'] ?? "",
        userId: parsedJson['userId'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': label,
      'date': date?.toIso8601String(),
      'timeInSeconds': timeInSeconds,
      'caloriesConsumed': caloriesConsumed,
      'userId': userId
    });
  }
}
