import 'package:alibtisam/features/bottomNav/model/team.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  List<TeamModel> teams = [];

  fetchTeams() async {
    LoadingManager.startLoading();
    teams = await ApiRequests().getTeams();
    update();
  }
}
