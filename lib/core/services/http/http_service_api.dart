import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:nu3virtual/core/services/authentication/authentication_service.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/service_locator.dart';

class HttpServiceApi extends HttpService {
  final AuthenticationStore _authenticationStore = getIt<AuthenticationStore>();

  static const hostedDeviceLocalhost =
      '10.0.2.2:'; //not localhost : https://stackoverflow.com/a/55786011/20009977
  static const apiUrl = '7251'; //NuVirtualApi url (not ISS server)

  Map<String, String> headers = {
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: ''
  };

  @override
  Future<Response> delete(String controllerName, int objetIdToDelete) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();
    Uri url = Uri.https(hostedDeviceLocalhost + apiUrl,
        '$controllerName/${objetIdToDelete.toString()}');
    return http.delete(url, headers: headers);
  }

  @override
  Future<Response> get(String controllerName, String? routeSuffix,
      List<String> addToHeaderNames, List<String> addToHeaderValues) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();

    for (int index = 0; index < addToHeaderNames.length; index += 1) {
      headers[addToHeaderNames[index]] = addToHeaderValues[index];
    }

    Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

    if (routeSuffix != null) {
      url = Uri.https(
          hostedDeviceLocalhost + apiUrl, '$controllerName/$routeSuffix');
    }
    return http.get(url, headers: headers);
  }

  @override
  Future<Response> patch(String controllerName, String? routeSuffix,
      List<String> addToHeaderNames, List<String> addToHeaderValues) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();

    for (int index = 0; index < addToHeaderNames.length; index += 1) {
      headers[addToHeaderNames[index]] = addToHeaderValues[index];
    }

    Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

    if (routeSuffix != null) {
      url = Uri.https(
          hostedDeviceLocalhost + apiUrl, '$controllerName/$routeSuffix');
    }

    return http.patch(url, headers: headers);
  }

  @override
  Future<Response> post(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues, String? body) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();

    for (int index = 0; index < addToHeaderNames.length; index += 1) {
      headers[addToHeaderNames[index]] = addToHeaderValues[index];
    }

    Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);
    return http.post(url, headers: headers, body: body);
  }

  @override
  Future<Response> put(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues, String body) async {
    headers[HttpHeaders.authorizationHeader] =
        await _authenticationStore.getToken();

    for (int index = 0; index < addToHeaderNames.length; index += 1) {
      headers[addToHeaderNames[index]] = addToHeaderValues[index];
    }
    Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);
    return http.put(url, headers: headers, body: body);
  }
}
