import 'package:http/http.dart';

abstract class HttpService {
  Future<Response> delete(String controllerName, int objetIdToDelete);
  Future<Response> get(String controllerName, String? routeSuffix,
      List<String> addToHeaderNames, List<String> addToHeaderValues);
  Future<Response> patch(String controllerName, String? routeSuffix,
      List<String> addToHeaderNames, List<String> addToHeaderValues);
  Future<Response> post(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues, String? body);
  Future<Response> put(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues, String body);
}
