import 'package:alibtisam_flutter/features/signup&login/presentation/login/login.dart';
import 'package:alibtisam_flutter/helper/localStorage/token_id.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> kLogoutUser(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "areYouSureYouWantToLogOut".tr,
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "no".tr,
                  style: TextStyle(color: primaryColor()),
                )),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: primaryColor()),
                onPressed: () {
                  LoadingManager.dummyLoading();
                  remove('token');
                  remove('uid');
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  "yes".tr,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      });
}
