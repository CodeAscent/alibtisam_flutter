import 'package:alibtisam/features/bottomNav/model/game.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class GamesController extends GetxController {
  List<GameModel> games = [];

  fetchGames({required String stage}) async {
    games = (await ApiRequests().getGames(stage: stage))!;
    update();
  }
}
