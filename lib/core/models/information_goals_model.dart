import 'dart:convert';

class InformationGoalsModel {
  int? id;
  String? name;
  double? value;
  DateTime? date;
  int? order;

  InformationGoalsModel(
      {this.id, this.name, this.value, this.date, this.order});

  factory InformationGoalsModel.fromJson(Map<String, dynamic> parsedJson) {
    return InformationGoalsModel(
        id: parsedJson['id'] ?? 0,
        name: parsedJson['name'] ?? "",
        value: parsedJson['value'] ?? 0,
        date: parsedJson['date'] != null
            ? DateTime.parse(parsedJson['date'])
            : null,
        order: parsedJson['order'] ?? 0);
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'value': value,
      'date': date?.toIso8601String(),
      'order': order
    });
  }
}
