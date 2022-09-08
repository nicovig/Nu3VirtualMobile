import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service_class.dart';

class MonitoringServiceStore extends MonitoringStore {
  @override
  Future<MonitoringModel> getMonitoring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> json =
        jsonDecode(prefs.getString('monitoring') as String);
    MonitoringModel monitoring = MonitoringModel.fromJson(json);
    return monitoring;
  }

  @override
  Future<void> updateMonitoring(MonitoringModel monitoringToUpdate) async {
    final prefs = await SharedPreferences.getInstance();
    String monitoringToUpdateString =
        MonitoringModel.objectToString(monitoringToUpdate);
    prefs.setString('monitoring', monitoringToUpdateString);
  }
}
