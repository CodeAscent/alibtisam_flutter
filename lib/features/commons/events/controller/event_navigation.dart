import 'package:get/get.dart';

class EventNavigation extends GetxController {
  Rx<bool> navigatingFromSplashScreen = false.obs;

  navigatingFromSplash(bool value) {
    navigatingFromSplashScreen.value = value;
    update();
  }
}
