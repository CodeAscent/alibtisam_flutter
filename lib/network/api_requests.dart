import 'dart:async';
import 'dart:convert';
import 'package:alibtisam/core/localStorage/fcm_token.dart';
import 'package:alibtisam/features/auth/view/screens/login.dart';
import 'package:alibtisam/features/bottomNav/bottom_nav.dart';
import 'package:alibtisam/features/bottomNav/controller/selected_player.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/model/attendance.dart';
import 'package:alibtisam/features/bottomNav/model/attendance_history.dart';
import 'package:alibtisam/features/bottomNav/model/attendance_statistics.dart';
import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam/features/bottomNav/model/dashboard.dart';
import 'package:alibtisam/features/bottomNav/model/game.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/team.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/settings/model/about.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/model/monitoring.dart';
import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/network/api_urls.dart';
import 'package:alibtisam/network/http_wrapper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

class ApiRequests {
  Future<List<Events>> allEvents(String filter) async {
    try {
      LoadingManager.startLoading();

      List<Events> events = [];
      final res =
          await HttpWrapper.getRequest(all_events + "?category=$filter");
      print(all_events + "?category=$filter");
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

  Future<List<Events>> allEventsWithDateFilter(
      String filter, String startDate, String endDate) async {
    try {
      LoadingManager.startLoading();

      List<Events> events = [];
      final res = await HttpWrapper.getRequest(all_events +
          "?category=$filter&startDate=$startDate&endDate=$endDate");
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
      required String clubId,
      required String mobile,
      required String name}) async {
    try {
      LoadingManager.startLoading();
      var body = {
        "role": "EXTERNAL USER",
        "email": email,
        "organizationId": clubId,
        "password": password,
        "mobile": num.parse(mobile),
        "name": name
      };
      final res = await HttpWrapper.postRequest(register_user, body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.offAll(() => LoginScreen());
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
      final fcmToken = await FcmToken().getFcmToken();
      var body = {
        "userName": userName,
        "password": password,
        "fcmToken": fcmToken,
        "device": "mobile"
      };
      final res = await HttpWrapper.postRequest(login_user, body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        saveToken(
          data['token'],
          data['user']['_id'],
        );
        Get.to(() => BottomNav());
      } else {
        customSnackbar(message: data["message"]);
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();

      customSnackbar(message: e.message);
    }
  }

  Future<void> logout() async {
    try {
      LoadingManager.startLoading();
      final fcmToken = await FcmToken().getFcmToken();
      var body = {"fcmToken": fcmToken};
      await HttpWrapper.postRequest(logout_user, body);
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
      Logger().w(data);
      if (res.statusCode == 200) {
        final user = UserModel.fromMap(data["user"]);
        saveToken(data["token"], user.id!);
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

  Future getMesurementRequests() async {
    try {
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(
          get_players_requests + "?status=COACH-REQUESTED");
      final data = jsonDecode(res.body);
      Logger().e(data);

      if (res.statusCode == 200) {
        return data['requests'];
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<List<UserModel>?> getMesurementHistory() async {
    List<UserModel> users = [];

    try {
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(
          get_players_requests + "?status=APPROVED");
      final data = jsonDecode(res.body);

      for (var item in data['requests']) {
        users.add(UserModel.fromMap(item['playerId']));
      }

      return users;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<DashboardModel>> getDashboardItems() async {
    try {
      List<DashboardModel> dashboardItems = [];
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(get_dashboard_services);
      final data = jsonDecode(res.body);
      for (var item in data['services']) {
        dashboardItems.add(DashboardModel.fromMap(item));
      }
      return dashboardItems;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }

  Future<List<UserModel>> getUsersByGuardian() async {
    try {
      LoadingManager.startLoading();

      String? guardianId = await getUid();
      final userController = Get.find<UserController>();
      if (userController.user!.guardianId != null) {
        guardianId = userController.user!.guardianId;
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

  Future getClubs() async {
    try {
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(get_organization_dropdown);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data['dropdown'];
      } else {
        customSnackbar(message: data['message']);
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
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
    required String city,
    required String state,
    required String relationWithApplicant,
    required XFile? idProofFrontPath,
    required XFile? idProofBackPath,
    required XFile? pic,
    required XFile? certificate,
    required String batch,
    required String gameId,
    required String stage,
    required String relationWithPlayer,
    required String playerGovId,
    required String guardianGovId,
    required String guardianGovIdExpiry,
    required String playerGovIdExpiry,
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
        "city": city,
        "state": state,
        "relation": relationWithApplicant,
        "batch": batch,
        "gameId": gameId,
        "stage": stage,
        "playerGovId": playerGovId,
        "relationWithPlayer": relationWithPlayer,
        "guardianGovId": guardianGovId,
        "guardianGovIdExpiry": guardianGovIdExpiry,
        "playerGovIdExpiry": playerGovIdExpiry
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
      final response = await res.stream.bytesToString();
      final data = jsonDecode(response);
      if (data["success"] == false) {
        customSnackbar(message: data["error"]);
      }
      return data;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future submitMeasurementRequest({
    required String height,
    required String weight,
    required String chestSize,
    required String normalChestSize,
    required String highJump,
    required String lowJump,
    required String heartBeatingRate,
    required String pulseRate,
    required String tshirtSize,
    required String waistSize,
    required String shoeSize,
    required String requestId,
    required String stage,
  }) async {
    try {
      LoadingManager.startLoading();
      var body = {
        "requestId": requestId,
        "height": num.parse(height),
        "weight": num.parse(weight),
        "chestSize": num.parse(chestSize),
        "normalChestSize": num.parse(normalChestSize),
        "highJump": num.parse(highJump),
        "lowJump": num.parse(lowJump),
        "heartBeatingRate": num.parse(heartBeatingRate),
        "pulseRate": num.parse(pulseRate),
        "tshirtSize": tshirtSize,
        "waistSize": num.parse(waistSize),
        "shoeSize": num.parse(shoeSize),
        "stage": stage,
      };
      final res = await HttpWrapper.postRequest(submit_measurement, body);
      final data = jsonDecode(res.body);
      Logger().w(res.body);
      if (res.statusCode == 200) {
        Get.back();
      }
      customSnackbar(message: data['message']);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<List<ChatMessages>?> getChatMessages() async {
    try {
      List<ChatMessages> messages = [];
      final res = await HttpWrapper.getRequest(get_chat_messages);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var message in data['messages']) {
          messages.add(ChatMessages.fromMap(message));
        }
        return messages;
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<Chat>?> getChatsList() async {
    try {
      List<Chat> chats = [];
      final res = await HttpWrapper.getRequest(get_chats_list);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var chat in data['chats']) {
          chats.add(Chat.fromMap(chat));
        }
        return chats;
      }
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<About?> getOrganization() async {
    try {
      final res = await HttpWrapper.getRequest(get_organization);
      final data = jsonDecode(res.body);
      return About.fromMap(data['organization']);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<MonitoringModel?> getMonitoringByPlayerId(String playerId) async {
    try {
      final res =
          await HttpWrapper.getRequest(get_monitoring_by_playerId + playerId);
      final data = jsonDecode(res.body);
      Logger().e(data);
      if (res.statusCode == 200) {
        MonitoringModel monitoring =
            MonitoringModel.fromMap(data['monitoring']);
        return monitoring;
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<MonitoringModel?>> getReportsByPlayerId() async {
    try {
      SelectedPlayerController selectedPlayerController =
          Get.find<SelectedPlayerController>();

      List<MonitoringModel> reports = [];
      final res = await HttpWrapper.getRequest(
          get_player_reports + selectedPlayerController.playerId);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var report in data['monitoring']) {
          reports.add(MonitoringModel.fromMap(report));
        }
        return reports;
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }

  Future<void> updateMonitoringByPlayerId(String playerId, Object body) async {
    try {
      LoadingManager.startLoading();
      final res = await HttpWrapper.postRequest(
          update_monitoring_by_playerId + playerId, body);
      final data = jsonDecode(res.body);
      customSnackbar(message: data['message']);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future getCollectionsByGameFilter(String gameId) async {
    try {
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(
          get_collection_by_game_filter + "?gameId=$gameId");
      final data = jsonDecode(res.body);
      return data['collection'];
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<List<GameModel>?> getGames({required String stage}) async {
    try {
      List<GameModel> games = [];
      LoadingManager.startLoading();
      final res = await HttpWrapper.getRequest(get_all_games + "?stage=$stage");
      final data = jsonDecode(res.body);
      Logger().w(data);
      for (var game in data['dropdown']) {
        games.add(GameModel.fromMap(game));
      }
      return games;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }

  Future<List<TeamModel>> getTeams() async {
    try {
      List<TeamModel> teams = [];
      final res = await HttpWrapper.getRequest(get_teams_by_coach);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var team in data['teams']) {
          teams.add(TeamModel.fromMap(team));
        }
      }
      return teams;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return [];
  }

  Future<Map<String, dynamic>> getAttendanceForInTime(
      {required String groupId}) async {
    List<AttendanceModel> attendance = [];
    try {
      final res = await HttpWrapper.postRequest(
          add_attendance + "?groupId=$groupId", {});

      final data = jsonDecode(res.body);
      print(data);
      for (var player in data['attendance']['players']) {
        if (player['playerId'] != null) {
          attendance.add(AttendanceModel.fromMap(player));
        }
      }
      return {
        "attendanceId": data['attendance']['_id'],
        "attendance": attendance
      };
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return {};
  }

  Future<Map<String, dynamic>> getAttendanceForOutTime(
      {required String attendanceId}) async {
    try {
      List<AttendanceModel> attendance = [];
      final res =
          await HttpWrapper.getRequest(get_marked_attendance + attendanceId);
      final data = jsonDecode(res.body);
      for (var player in data['attendance']['players']) {
        attendance.add(AttendanceModel.fromMap(player));
      }
      return {"attendanceId": attendanceId, "attendance": attendance};
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return {};
  }

  Future<Map<String, dynamic>> getSingleAttendanceById(
      {required String attendanceId}) async {
    try {
      List<AttendanceModel> attendance = [];
      final res =
          await HttpWrapper.getRequest(get_completed_attendance + attendanceId);
      final data = jsonDecode(res.body);
      for (var player in data['attendance']['players']) {
        attendance.add(AttendanceModel.fromMap(player));
      }
      return {"attendanceId": attendanceId, "attendance": attendance};
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return {};
  }

  Future<List<AttendanceHistoryModel>?> getAttendanceHistory(
      {required String groupId}) async {
    List<AttendanceHistoryModel> attendances = [];
    try {
      final res = await HttpWrapper.getRequest(
          get_all_completed_attendance + "?groupId=$groupId");
      final data = jsonDecode(res.body);
      Logger().w(data);
      for (var attendance in data['attendances']) {
        attendances.add(AttendanceHistoryModel.fromMap(attendance));
      }
      return attendances;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future markAttendance(
      {required String attendanceId,
      required List<PlayersAttendance> playersAttendance}) async {
    try {
      List playersList =
          playersAttendance.map((player) => player.toMap()).toList();

      await HttpWrapper.postRequest(mark_attendance + attendanceId, {
        "playerIds": playersList,
      });
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
  }

  Future<List<AttendanceHistoryModel>> getPlayerAttendanceHistory() async {
    List<AttendanceHistoryModel> playerAttendances = [];
    try {
      final res = await HttpWrapper.getRequest(get_player_attendance);
      final data = jsonDecode(res.body);
      print(data);
      for (var attendance in data['attendances']) {
        playerAttendances.add(AttendanceHistoryModel.fromMap(attendance));
      }
      Logger().w(playerAttendances);
      return playerAttendances;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return playerAttendances;
  }

  Future<AttendanceStatisticsModel?> getPlayerAttendanceStatistics() async {
    try {
      final res =
          await HttpWrapper.getRequest(get_player_attendance_statistics);
      final data = jsonDecode(res.body);
      Logger().w(data['statistics']);
      return AttendanceStatisticsModel.fromMap(data['statistics']);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<GroupModel>?> getGroups(
      {required String stage, required String gameId}) async {
    try {
      List<GroupModel>? groups = [];
      final res = await HttpWrapper.getRequest(
          base_url + "group/all?gameId=$gameId&stage=$stage");
      Logger().w(res.body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var group in data['groups']) {
          groups.add(GroupModel.fromMap(group));
        }
      }
      return groups;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<GroupModel?> createGroup(
      {required String stage,
      required String gameId,
      required String name}) async {
    try {
      GroupModel? group;
      final res = await HttpWrapper.postRequest(base_url + "group/add", {
        "gameId": gameId,
        "stage": stage,
        "name": name,
      });
      final data = jsonDecode(res.body);
      Logger().w(data);
      group = GroupModel.fromMap(data['group']);
      return group;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<UserModel>?> getPlayersByGroup({
    required String groupId,
  }) async {
    try {
      List<UserModel>? users = [];
      final res =
          await HttpWrapper.getRequest(base_url + "group/members/" + groupId);
      final data = jsonDecode(res.body);
      for (var item in data['members']) {
        Logger().w(item);
        if (item['memberId'] != null) {
          users.add(UserModel.fromMap(item['memberId']));
        }
      }
      return users;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<UserModel>?> getPlayersByStage({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];
      final res = await HttpWrapper.getRequest(
          base_url + "player/players?stage=" + stage);
      final data = jsonDecode(res.body);
      for (var item in data['players']) {
        Logger().w(item);
        if (item != null) {
          users.add(UserModel.fromMap(item));
        }
      }
      return users;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }
  Future<List<UserModel>?> getCoachesByStage({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];
    final  userController = Get.find<UserController>();
      final res = await HttpWrapper.getRequest(
          base_url + "coach/all?stage=$stage&gameId=${userController.user!.gameId!.id}" );
      final data = jsonDecode(res.body);
      for (var item in data['coaches']) {
        Logger().w(item);
        if (item != null) {
          users.add(UserModel.fromMap(item));
        }
      }
      return users;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<UserModel>?> getCoachesByGame({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];
      //   final res = await HttpWrapper.getRequest(
      //       base_url + "player/players?stage=" + stage);
      //   final data = jsonDecode(res.body);
      //   for (var item in data['players']) {
      //     Logger().w(item);
      //     if (item != null) {
      //       users.add(UserModel.fromMap(item));
      //     }
      //   }
      return users;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future addMemberToGroup(
      {required String memberId, required String groupId}) async {
    try {
      final res = await HttpWrapper.postRequest(base_url + "group/member/add", {
        "groupId": groupId,
        "memberId": memberId,
      });

      Logger().e({
        "groupId": groupId,
        "memberId": memberId,
      });
      Logger().e(base_url + "group/member/add");
      Logger().e(res.body);
      //   final data = jsonDecode(res.body);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future updateGroupMembers(
      {required List members, required String groupId}) async {
    try {
      final res =
          await HttpWrapper.patchRequest(base_url + "group/members/update", {
        "groupId": groupId,
        "members": members,
      });

      Logger().e(res.body);
      //   final data = jsonDecode(res.body);
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future updatePlayerStage({
    required String playerId,
    required String stage,
    required String groupId,
  }) async {
    try {
      final res = await HttpWrapper.postRequest(
          base_url + "coach/polarize-player",
          stage == 'SCHOOL'
              ? {"playerId": playerId, "stage": stage, "groupId": groupId}
              : {
                  "playerId": playerId,
                  "stage": stage,
                });
      Logger().e(base_url + "coach/polarize-player");
      Logger().e({"playerId": playerId, "stage": stage});
      Logger().e(res.body);
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        Get.back();
        customSnackbar(message: data['message']);
      } else {
        customSnackbar(message: data['error']);
      }
    } on ServerException catch (e) {
      //   await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }

  Future<List<GroupModel>?> playerGroups() async {
    try {
      List<GroupModel>? groups = [];

      final res = await HttpWrapper.getRequest(
        base_url + "group/me",
      );

      final data = jsonDecode(res.body);
      Logger().w(data);
      for (var group in data['groups']) {
        groups.add(GroupModel.fromMap(group['groupId']));
      }

      return groups;
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return null;
  }
}
