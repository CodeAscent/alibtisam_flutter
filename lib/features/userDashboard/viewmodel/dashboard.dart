import 'package:alibtisam/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:alibtisam/features/userDashboard/models/dashboard.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/features/userDashboard/repo/dashboard.dart';
import 'package:get/get.dart';

enum ViewState { Idle, Busy }

class DashboardViewModel extends GetxController {
  final DashboardRepo dashboardRepo;

  DashboardViewModel(this.dashboardRepo);
  List<DashboardModel> dashboard = [];

  ViewState get state => _state;
  ViewState _state = ViewState.Idle;
  Future fetchDashboardItems() async {
    dashboard = [];
    _state = ViewState.Busy;
    dashboard = await dashboardRepo.getDashboardItems();
    _state = ViewState.Idle;
    update();
  }
}
