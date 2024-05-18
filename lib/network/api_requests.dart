import 'dart:convert';

import 'package:alibtisam_flutter/features/commons/events/model/events_model.dart';
import 'package:alibtisam_flutter/features/commons/home/custom_bottom_nav.dart';
import 'package:alibtisam_flutter/features/commons/home/presentation/settings/models/user.dart';
import 'package:alibtisam_flutter/helper/error/server_exception.dart';
import 'package:alibtisam_flutter/helper/localStorage/token.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:alibtisam_flutter/network/http_wrapper.dart';
import 'package:get/get.dart';

class ApiRequests {
  Future<List<Events>> allEvents(String filter) async {
    try {
      LoadingManager.startLoading();

      List<Events> events = [];
      final res =
          await HttpWrapper.getRequest(all_events + "?category=$filter");
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var item in data['events']) {
          events.add(Events.fromMap(item));
        }
      }
      await LoadingManager.endLoading();

      return events;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }

  Future<void> register(
      {required String email,
      required String password,
      required String mobile,
      required String name}) async {
    try {
      LoadingManager.startLoading();
      var body = {
        "role": "EXTERNAL USER",
        "email": email,
        "password": password,
        "mobile": num.parse(mobile),
        "name": name
      };
      final res = await HttpWrapper.postRequest(register_user, body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.back();
      }
      customSnackbar(message: data["message"]);

      await LoadingManager.endLoading();
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<void> login(
      {required String userName, required String password}) async {
    try {
      LoadingManager.startLoading();
      var body = {"userName": userName, "password": password};
      final res = await HttpWrapper.postRequest(login_user, body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        saveToken(data['token']);
        Get.to(() => CustomBottomNav());
      } else {
        customSnackbar(message: data["message"]);
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }

  Future<UserModel?> getUser() async {
    try {
      LoadingManager.startLoading();

      final res = await HttpWrapper.getRequest(get_user);

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return UserModel.fromMap(data["user"]);
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }
}
