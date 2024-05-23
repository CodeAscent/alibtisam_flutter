import 'dart:async';
import 'dart:convert';

import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam_flutter/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam_flutter/helper/error/server_exception.dart';
import 'package:alibtisam_flutter/helper/localStorage/token_id.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_urls.dart';
import 'package:alibtisam_flutter/network/http_wrapper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
        saveToken(data['token'], data['user']['_id']);
        Get.to(() => BottomNav());
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
        print(data);
        final user = UserModel.fromMap(data["user"]);
        final userController = Get.find<UserController>();
        userController.setUserData(user);
        saveToken(data["token"], user.id);
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

  Future<void> getTokenById(String id) async {
    try {
      final res = await HttpWrapper.getRequest(get_token_by_id + id);
      final data = jsonDecode(res.body);
      saveToken(data['token'], id);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<List<UserModel>> getUsersByGuardian() async {
    try {
      LoadingManager.startLoading();

      String? guardianId = await getUid();
      final userController = Get.find<UserController>();
      if (userController.user.guardianId != '') {
        guardianId = userController.user.guardianId;
      }

      final res =
          await HttpWrapper.getRequest(get_player_by_guardian + "$guardianId");
      final data = jsonDecode(res.body);
      List<UserModel> players = [];
      for (var item in data['players']) {
        players.add(UserModel.fromMap(item));
      }
      return players;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }
  // Future<void> updateUser(File? file) async {
  //   try {
  //     String uid = await getUid() ?? '';
  //     String url = update_user + uid;
  //     List<File> files = [];
  //     files.add(file!);
  //     // final res = await HttpWrapper.multipartRequest(url, files);
  //     // print(res.body);
  //   } on ServerException catch (e) {
  //     await LoadingManager.endLoading();
  //     customSnackbar(message: e.message);
  //   }
  // }

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
    required XFile? pic,
    required XFile? certificate,
    required String batch,
    required String gameId,
    required String institutionalTypes,
  }) async {
    try {
      LoadingManager.startLoading();

      String url = create_player;
      Map<String, String>? fields = {
        "name": name,
        "fatherName": fatherName,
        "motherName": motherName,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "bloodGroup": bloodGroup,
        "height": height,
        "weight": weight,
        "mobile": phoneNumber,
        "email": email,
        "address": address,
        "correspondenceAddress": correspondenceAddress,
        "postalCode": postalCode,
        "city": city,
        "state": state,
        "country": country,
        "relation": relationWithApplicant,
        "batch": batch,
        "gameId": "663b6e7e84b08ed875f84d91",
        "institutionalTypes": institutionalTypes,
      };
      List<http.MultipartFile> files = [];
      files.addAll([
        await http.MultipartFile.fromPath("pic", pic!.path),
        await http.MultipartFile.fromPath(
            "idFrontImage", idProofFrontPath!.path),
        await http.MultipartFile.fromPath("idBackImage", idProofBackPath!.path),
      ]);
      if (certificate != null) {
        files.add(await http.MultipartFile.fromPath(
            "certificateLink", certificate.path));
      }
      final res =
          await HttpWrapper.multipartRequest(url, files, fields: fields);
      final data = await res.stream.bytesToString();
      return jsonDecode(data);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }
}
