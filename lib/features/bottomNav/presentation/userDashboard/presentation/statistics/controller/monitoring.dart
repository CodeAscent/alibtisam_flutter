import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/model/monitoring.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  MonitoringModel? monitoring;

  fetchMonitoringData(String playerId) async {
    LoadingManager.startLoading();
    monitoring = await ApiRequests().getMonitoringByPlayerId(playerId);
    update();
  }
}
