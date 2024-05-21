import 'package:alibtisam_flutter/helper/localStorage/theme.dart';
import 'package:alibtisam_flutter/helper/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<String> liveTheme = "".obs;
  Rx<String> selectedTheme = "".obs;
  Rx<Color> liveGreyColor = Colors.grey.shade200.obs;
  setGreyColor(val) {
    if (val == 'dark') {
      liveGreyColor.value = Colors.grey.shade900;
    } else {
      liveGreyColor.value = Colors.grey.shade200;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getSharedPrefData();
  }

  getSharedPrefData() async {
    switchTheme(await getSharedPrefTheme());
    update();
  }

  void updateSelectedTheme(String val) {
    selectedTheme.value = val;
    update();
  }

  void switchTheme(String val) {
    liveTheme.value = val;
    switchSharedPrefTheme(val);
    setGreyColor(val);

    update();
  }

  ThemeData appTheme() {
    if (liveTheme.value == 'light') {
      return kAppThemeLight();
    } else {
      return kAppThemeDark();
    }
  }

  bool isDarkTheme() {
    if (liveTheme.value == 'light') {
      return false;
    }
    return true;
  }
}
