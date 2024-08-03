import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class PlayerPolarizationController extends GetxController {
  List<UserModel> players = [];
  RxBool loading = false.obs;
  fetchPlayersByStage(String stage) async {
    loading.value = true;
    players = [];
    players = (await ApiRequests().getPlayersByStage(stage: stage))!;
    loading.value = false;
    update();
  }
}
