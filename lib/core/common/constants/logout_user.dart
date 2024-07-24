import 'package:alibtisam/features/auth/presentation/login.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_requests.dart';
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
                onPressed: () async {
                  await ApiRequests().logout();
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
