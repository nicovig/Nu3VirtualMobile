import 'package:http/http.dart';

abstract class HttpService {
  Future<Response> delete(String controllerName, int objetIdToDelete);
  Future<Response> get(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues);
  Future<Response> patch();
  Future<Response> post(String controllerName, List<String> addToHeaderNames,
      List<String> addToHeaderValues, String body);
  Future<Response> put();
}
