import 'package:nu3virtual/core/models/monitoring_model.dart';
import 'package:nu3virtual/core/models/user_model.dart';

abstract class MonitoringStore {
  Future<MonitoringModel> getMonitoring();
  Future<void> updateMonitoring(MonitoringModel monitoringToUpdate);
}
