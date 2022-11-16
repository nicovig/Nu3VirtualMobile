import 'package:nu3virtual/core/models/monitoring_model.dart';

abstract class MonitoringService {
  Future<MonitoringModel> getMonitoringByUserIdAndDate(
      int? userId, DateTime date);
}
