import 'package:SNP/features/bottomNav/model/team.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  List<TeamModel> teams = [];

  fetchTeams() async {
    LoadingManager.startLoading();
    teams = await ApiRequests().getTeams();
    update();
  }
}
