import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/service_locator.dart';

class MonitoringServiceApi extends MonitoringService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();

  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)
  static const controllerName = 'Monitoring';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  Map<String, String> headers = {
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: ''
  };

  @override
  Future<MonitoringModel> getMonitoringByUserIdAndDate(
      int? userId, DateTime date) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    headers['userId'] = userId.toString();
    headers['date'] = date.toIso8601String();

    var response = await http.get(
      url,
      headers: headers,
    );

    var monitoring = MonitoringModel.fromJson(response.body);
    return monitoring;
  }
}
