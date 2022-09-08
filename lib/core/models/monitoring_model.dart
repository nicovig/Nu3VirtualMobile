import 'dart:convert';

class MonitoringModel {
  String? date;
  int? carbohydrateAmount;
  int? lipidAmount;
  int? proteinAmount;
  int? calorieAmount;

  MonitoringModel(
      {this.date,
      this.carbohydrateAmount,
      this.lipidAmount,
      this.proteinAmount,
      this.calorieAmount});

  factory MonitoringModel.fromJson(Map<String, dynamic> parsedJson) {
    return MonitoringModel(
        date: parsedJson["date"],
        carbohydrateAmount: parsedJson["carbohydrateAmount"],
        lipidAmount: parsedJson["lipidAmount"],
        proteinAmount: parsedJson["proteinAmount"],
        calorieAmount: parsedJson["calorieAmount"]);
  }

  String toJson() {
    return jsonEncode({
      'date': date,
      'carbohydrateAmount': carbohydrateAmount,
      'lipidAmount': lipidAmount,
      'proteinAmount': proteinAmount,
      'calorieAmount': calorieAmount
    });
  }

  static String objectToString(MonitoringModel monitoring) {
    return '{"date": ${monitoring.date}, "carbohydrateAmount": "${monitoring.carbohydrateAmount}", "lipidAmount": "${monitoring.lipidAmount}", "proteinAmount": "${monitoring.proteinAmount}", "calorieAmount": "${monitoring.calorieAmount}"}';
  }
}
