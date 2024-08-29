import 'package:alibtisam/features/bottomNav/model/team.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class TeamsController extends GetxController {
  List<TeamModel> teams = [];

  fetchTeams() async {
    teams = await ApiRequests().getTeams();
    update();
  }
}
