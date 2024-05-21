import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

class ActivePlayerController extends GetxController {
  late PodPlayerController activePlayer;

  void setActivePlayer(PodPlayerController playerController) {
    activePlayer = playerController;
    update();
  }

  void pauseActive() {
    activePlayer.pause();
    update();
  }
}
