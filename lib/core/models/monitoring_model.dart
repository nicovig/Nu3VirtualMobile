import 'dart:convert';

class MonitoringModel {
  List<NutritionGoalMonitoringModel> nutritionGoalsMonitoring;

  MonitoringModel({required this.nutritionGoalsMonitoring});

  factory MonitoringModel.fromJson(String jsonResponse) {
    final Map<String, dynamic> untypedObject = jsonDecode(jsonResponse);

    dynamic dynamicNutritionGoalMonitoringModel = untypedObject.values.last
        .map((e) => NutritionGoalMonitoringModel.fromJson(e))
        .toList();

    List<NutritionGoalMonitoringModel> nutritionGoalsMonitoring = [];
    for (var i = 0; i < dynamicNutritionGoalMonitoringModel.length; i++) {
      nutritionGoalsMonitoring.add(dynamicNutritionGoalMonitoringModel[i]);
    }

    return MonitoringModel(nutritionGoalsMonitoring: nutritionGoalsMonitoring);
  }
}

class NutritionGoalMonitoringModel {
  MonitoringInformationTypeEnum type;
  int value;

  NutritionGoalMonitoringModel({required this.type, required this.value});

  factory NutritionGoalMonitoringModel.fromJson(
      Map<String, dynamic> parsedJson) {
    return NutritionGoalMonitoringModel(
        type: MonitoringInformationTypeEnum.values[parsedJson['type']],
        value: parsedJson["value"]);
  }
}

enum MonitoringInformationTypeEnum {
  caloriesBurned,
  caloriesConsumed,
  carbohydrate,
  lipid,
  protein
}
