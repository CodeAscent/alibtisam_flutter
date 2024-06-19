import 'package:SNP/features/bottomNav/model/game.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class GamesController extends GetxController {
  List<GameModel> games = [];

  fetchGames({required String date}) async {
    LoadingManager.startLoading();
    games = (await ApiRequests().getGames(date: date))!;
    update();
  }
}
