import 'package:alibtisam_flutter/features/bottomNav/model/team.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  List<TeamModel> teams = [];

  fetchTeams() async {
    LoadingManager.startLoading();
    teams = await ApiRequests().getTeams();
    update();
  }
}
