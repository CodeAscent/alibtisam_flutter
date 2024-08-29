import 'package:alibtisam/features/statistics/model/monitoring.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  MonitoringModel? monitoring;

  fetchMonitoringData(String playerId) async {
    monitoring = await ApiRequests().getMonitoringByPlayerId(playerId);
    update();
  }
}
