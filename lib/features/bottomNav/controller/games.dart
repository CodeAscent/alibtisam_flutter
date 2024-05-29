import 'package:alibtisam_flutter/features/bottomNav/model/game.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class GamesController extends GetxController {
  List<GameModel> games = [];

  fetchGames() async {
    LoadingManager.startLoading();
    games = (await ApiRequests().getGames())!;
    update();
  }
}
