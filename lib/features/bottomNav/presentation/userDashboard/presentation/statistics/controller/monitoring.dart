import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/model/monitoring.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class MonitoringController extends GetxController {
  MonitoringModel? monitoring;

  fetchMonitoringData(String playerId) async {
    LoadingManager.startLoading();
    monitoring = await ApiRequests().getMonitoringByPlayerId(playerId);
    update();
  }
}
