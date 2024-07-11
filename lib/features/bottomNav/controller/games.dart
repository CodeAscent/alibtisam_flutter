import 'package:alibtisam/features/bottomNav/model/game.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:get/get.dart';

class GamesController extends GetxController {
  List<GameModel> games = [];

  fetchGames({required String date, required String stage}) async {
    LoadingManager.startLoading();
    games = (await ApiRequests().getGames(date: date, stage: stage))!;
    update();
  }
}
