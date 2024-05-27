import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<dynamic> kConfirmExit(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "areYouSureYouWantToExit".tr,
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "no".tr,
                  style: TextStyle(color: primaryColor()),
                )),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: primaryColor()),
                onPressed: () {
                  Get.back();
                  SystemNavigator.pop();
                },
                child: Text(
                  "yes".tr,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      });
}
