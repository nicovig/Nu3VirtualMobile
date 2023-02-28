import 'package:flutter/material.dart';

import 'package:nu3virtual/core/const/colors.dart';
import 'package:nu3virtual/core/helpers/helpers.dart';
import 'package:nu3virtual/core/models/monitoring_model.dart';

class MonitoringBox extends StatelessWidget {
  MonitoringBox({
    Key? key,
    required this.date,
    required this.monitoring,
  }) : super(key: key);
  final DateTime date;
  final MonitoringModel monitoring;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      decoration: BoxDecoration(
        color: color_4,
        border: Border.all(
          color: color_5,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              getMonitoringDate(date, context),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                getMonitoringBoxFirstLine(monitoring.nutritionGoalsMonitoring),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getMonitoringBoxSecondLine(
                  monitoring.nutritionGoalsMonitoring),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getMonitoringBoxFirstLine(
    List<NutritionGoalMonitoringModel> nutritionGoalMonitoring) {
  List<Widget> lineText = [];

  int monitoringTextOnLine = nutritionGoalMonitoring.length > 3 ? 2 : 1;

  if (nutritionGoalMonitoring.isNotEmpty) {
    for (var i = 0; i < monitoringTextOnLine; i++) {
      if (nutritionGoalMonitoring.length > 3 && i != 1) {
        lineText.add(const Spacer());
      }
      lineText.add(Text(
        getMonitoringBoxText(nutritionGoalMonitoring[i]),
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ));
      if (nutritionGoalMonitoring.length > 3) {
        lineText.add(const Spacer());
      }
    }
  }
  return lineText;
}

List<Widget> getMonitoringBoxSecondLine(
    List<NutritionGoalMonitoringModel> nutritionGoalMonitoring) {
  List<Widget> lineText = [];

  int startTo = nutritionGoalMonitoring.length > 3 ? 2 : 1; //zero based
  int monitoringTextOnLine = 3;

  if (nutritionGoalMonitoring.length == 2) {
    monitoringTextOnLine = 1;
  } else if (nutritionGoalMonitoring.length == 3 ||
      nutritionGoalMonitoring.length == 4) {
    monitoringTextOnLine = 2;
  }

  if (nutritionGoalMonitoring.length > 1) {
    for (var i = startTo; i < nutritionGoalMonitoring.length; i++) {
      if (monitoringTextOnLine != 1 && i == startTo) {
        lineText.add(const Spacer());
      }

      lineText.add(Text(
        getMonitoringBoxText(nutritionGoalMonitoring[i]),
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ));

      if (monitoringTextOnLine != 1) {
        lineText.add(const Spacer());
      }
    }
  }
  return lineText;
}

String getMonitoringBoxText(
    NutritionGoalMonitoringModel nutritionGoalMonitoring) {
  switch (nutritionGoalMonitoring.type) {
    case MonitoringInformationTypeEnum.caloriesBurned:
      return "Cal brûlées : ${nutritionGoalMonitoring.value}";

    case MonitoringInformationTypeEnum.caloriesConsumed:
      return "Cal consommées : ${nutritionGoalMonitoring.value}";

    case MonitoringInformationTypeEnum.carbohydrate:
      return "Glucides : ${nutritionGoalMonitoring.value}";

    case MonitoringInformationTypeEnum.lipid:
      return "Lipides : ${nutritionGoalMonitoring.value}";

    case MonitoringInformationTypeEnum.protein:
      return "Protéines : ${nutritionGoalMonitoring.value}";
  }
}
