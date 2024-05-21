import 'package:alibtisam_flutter/helper/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> kSwitchThemeDialog(BuildContext context) {
  final themeController = Get.find<ThemeController>();
  themeController.updateSelectedTheme(themeController.selectedTheme.value);
  print(themeController.liveTheme.value);
  return showDialog(
    context: context,
    builder: (context) {
      return Obx(() {
        return AlertDialog(
          title: Text("Theme"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    themeController.updateSelectedTheme('light');
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeController.selectedTheme.value == 'light'
                          ? themeController.liveGreyColor.value
                          : null,
                    ),
                    child: Text("Light"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    themeController.updateSelectedTheme('dark');
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeController.selectedTheme.value == 'dark'
                          ? themeController.liveGreyColor.value
                          : null,
                    ),
                    child: Text("Dark"),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  themeController
                      .switchTheme(themeController.selectedTheme.value);
                  Get.back();
                },
                child: Text("Confirm"))
          ],
        );
      });
    },
  );
}
