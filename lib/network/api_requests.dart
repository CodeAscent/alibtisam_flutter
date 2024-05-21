import 'dart:convert';

import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam_flutter/features/bottomNav/custom_bottom_nav.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/models/user.dart';
import 'package:alibtisam_flutter/helper/error/server_exception.dart';
import 'package:alibtisam_flutter/helper/localStorage/token.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:alibtisam_flutter/network/http_wrapper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
      await LoadingManager.endLoading();

      customSnackbar(message: e.message);
    }
  }

  Future<UserModel?> getUser() async {
    try {
      LoadingManager.startLoading();

      final res = await HttpWrapper.getRequest(get_user);

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final user = UserModel.fromMap(data["user"]);
        final userController = Get.find<UserController>();
        userController.setUserData(user);
        return user;
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future createPlayerForm({
    required String name,
    required String fatherName,
    required String motherName,
    required String gender,
    required String dateOfBirth,
    required String bloodGroup,
    required String height,
    required String weight,
    required String phoneNumber,
    required String email,
    required String address,
    required String correspondenceAddress,
    required String postalCode,
    required String city,
    required String state,
    required String country,
    required String relationWithApplicant,
    required XFile? idProofFrontPath,
    required XFile? idProofBackPath,
    required XFile? photoPath,
    required XFile? certificate,
    required String batch,
    required String gameId,
    required String institutionalTypes,
  }) async {
    String url = create_player;
  }
}
