import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';

class MonitoringServiceApi extends MonitoringService {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost = '10.0.2.2:';
  static const apiUrl = '44383';
  static const controllerName = 'Monitoring';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<MonitoringModel> getMonitoringByUserIdAndDate(
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

    final Map<String, dynamic> untypedObject = jsonDecode(response.body);
    final MonitoringModel monitoring = MonitoringModel.fromJson(untypedObject);

    return monitoring;
  }
}
