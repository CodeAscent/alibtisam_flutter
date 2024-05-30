import 'package:get/get.dart';

class SelectedPlayerController extends GetxController {
  String playerId = "";

  updatePlayerId(userId) {
    playerId = userId;
    update();
  }
}
