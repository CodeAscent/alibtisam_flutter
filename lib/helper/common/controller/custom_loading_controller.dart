import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomLoadingController extends GetxController {
  bool loading = false;

  dummyLoading() async {
    loading = true;
    update();

    await Future.delayed(Duration(seconds: 1));
    loading = false;
    update();
  }

  startLoading() {
    loading = true;
    update();
  }

  endLoading() async {
    await Future.delayed(Duration(milliseconds: 500));
    loading = false;
    update();
  }
}
