import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/services/http/http_service.dart';
import 'package:nu3virtual/core/services/monitoring/monitoring_service.dart';
import 'package:nu3virtual/service_locator.dart';

class MonitoringServiceApi extends MonitoringService {
  final HttpService _httpService = getIt<HttpService>();

  static const controllerName = 'Monitoring';

  @override
  Future<MonitoringModel> getMonitoringByUserIdAndDate(
      int? userId, DateTime date) async {
    MonitoringModel monitoring = MonitoringModel(nutritionGoalsMonitoring: []);
    var dateTest = date.toIso8601String();
    var response = await _httpService.get(controllerName, null,
        ['userId', 'date'], [userId.toString(), date.toIso8601String()]);
    if (_httpService.isResponseOk(response.statusCode)) {
      monitoring = MonitoringModel.fromJson(response.body);
    }
    return monitoring;
  }
}
