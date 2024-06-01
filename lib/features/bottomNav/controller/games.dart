import 'package:SNP/features/bottomNav/model/game.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class GamesController extends GetxController {
  List<GameModel> games = [];

  fetchGames() async {
    LoadingManager.startLoading();
    games = (await ApiRequests().getGames())!;
    update();
  }
}
