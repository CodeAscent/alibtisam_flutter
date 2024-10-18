import 'dart:async';
import 'dart:convert';

import 'package:alibtisam/features/bottomNav/controller/selected_player.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/attendance/models/attendance.dart';
import 'package:alibtisam/features/attendance/models/attendance_history.dart';
import 'package:alibtisam/features/attendance/models/attendance_statistics.dart';
import 'package:alibtisam/features/bottomNav/model/chat_message.dart';
import 'package:alibtisam/features/bottomNav/model/chats_list.dart';
import 'package:alibtisam/features/bottomNav/model/game.dart';
import 'package:alibtisam/features/bottomNav/model/group_model.dart';
import 'package:alibtisam/features/bottomNav/model/team.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/settings/model/about.dart';
import 'package:alibtisam/features/events/model/events_model.dart';
import 'package:alibtisam/features/statistics/model/monitoring.dart';
import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/localStorage/token_id.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ApiRequests {
  Future<List<Events>> allEvents(String filter) async {
    try {
      List<Events> events = [];
      final res = await HttpWrapper.getRequest(
          all_events + "?category=$filter&active=true");
      print(all_events + "?category=$filter");
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var item in data['events']) {
          events.add(Events.fromMap(item));
        }
      }

      return events;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return [];
  }

  Future<List<Events>> allEventsWithDateFilter(
      String filter, String startDate, String endDate) async {
    try {
      List<Events> events = [];
      final res = await HttpWrapper.getRequest(all_events +
          "?category=$filter&startDate=$startDate&endDate=$endDate&active=true");
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var item in data['events']) {
          events.add(Events.fromMap(item));
        }
      }

      return events;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return [];
  }

  Future<UserModel?> getUser() async {
    try {
      final res = await HttpWrapper.getRequest(get_user);

      final data = jsonDecode(res.body);
      Logger().w(data);

      if (res.statusCode == 200) {
        final user = UserModel.fromMap(data["user"]);

        saveToken(data["token"], user.id!);
        return user;
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<void> getTokenById(String id) async {
    try {
      final res = await HttpWrapper.getRequest(get_token_by_id + id);
      final data = jsonDecode(res.body);
      saveToken(data['token'], id);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
  }

  Future getMesurementRequests() async {
    try {
      final res = await HttpWrapper.getRequest(
          get_players_requests + "?status=COACH-REQUESTED");
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        // customSnackbar(data['message'], ContentType.success);
        return data['requests'];
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
  }

  Future<List<UserModel>?> getMesurementHistory() async {
    List<UserModel> users = [];

    try {
      final res = await HttpWrapper.getRequest(
          get_players_requests + "?status=APPROVED");
      final data = jsonDecode(res.body);

      for (var item in data['requests']) {
        users.add(UserModel.fromMap(item['playerId']));
      }

      return users;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<List<UserModel>> getUsersByGuardian() async {
    try {
      String? guardianId = await getUid();
      final userController = Get.find<UserController>();
      if (userController.user!.guardianId != null) {
        guardianId = userController.user!.guardianId;
      }
      final res =
          await HttpWrapper.getRequest(get_player_by_guardian + "$guardianId");
      final data = jsonDecode(res.body);
      Logger().w(data);
      List<UserModel> players = [];
      for (var item in data['players']) {
        players.add(UserModel.fromMap(item));
      }
      return players;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return [];
  }

  Future getClubs() async {
    try {
      final res = await HttpWrapper.getRequest(get_organization_dropdown);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        return data['dropdown'];
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      if (res.statusCode == 200) {
        Get.back();
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<About?> getOrganization() async {
    try {
      final res = await HttpWrapper.getRequest(get_organization);
      final data = jsonDecode(res.body);
      return About.fromMap(data['organization']);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<MonitoringModel?> getMonitoringByPlayerId(String playerId) async {
    try {
      final res =
          await HttpWrapper.getRequest(get_monitoring_by_playerId + playerId);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        MonitoringModel monitoring =
            MonitoringModel.fromMap(data['monitoring']);
        return monitoring;
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
    }
    return [];
  }

  Future<void> updateMonitoringByPlayerId(String playerId, Object body) async {
    try {
      final res = await HttpWrapper.postRequest(
          update_monitoring_by_playerId + playerId, body);
      final data = jsonDecode(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
  }

  Future getCollectionsByGameFilter(String gameId) async {
    try {
      final res = await HttpWrapper.getRequest(
          get_collection_by_game_filter + "?gameId=$gameId");
      final data = jsonDecode(res.body);
      return data['collection'];
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
  }

  Future<List<GameModel>?> getGames({required String stage}) async {
    try {
      List<GameModel> games = [];
      final res;
      if (stage == '') {
        res = await HttpWrapper.getRequest(get_all_games);
      } else {
        res = await HttpWrapper.getRequest(get_all_games + "?stage=$stage");
      }
      final data = jsonDecode(res.body);
      for (var game in data['dropdown']) {
        games.add(GameModel.fromMap(game));
      }
      return games;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
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
        Logger().f(player);

        attendance.add(AttendanceModel.fromMap(player));
      }
      return {"attendanceId": attendanceId, "attendance": attendance};
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
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
      for (var attendance in data['attendances']) {
        attendances.add(AttendanceHistoryModel.fromMap(attendance));
      }
      return attendances;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      customSnackbar(e.message, ContentType.failure);
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
      return playerAttendances;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return playerAttendances;
  }

  Future<AttendanceStatisticsModel?> getPlayerAttendanceStatistics() async {
    try {
      final res =
          await HttpWrapper.getRequest(get_player_attendance_statistics);
      final data = jsonDecode(res.body);
      return AttendanceStatisticsModel.fromMap(data['statistics']);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<List<GroupModel>?> getGroups(
      {required String stage, required String gameId}) async {
    try {
      List<GroupModel>? groups = [];
      final res = await HttpWrapper.getRequest(
          base_url + "group/coach-all?gameId=$gameId&stage=$stage");
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        for (var group in data['groups']) {
          groups.add(GroupModel.fromMap(group));
        }
      }
      return groups;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      group = GroupModel.fromMap(data['group']);
      return group;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
        if (item['memberId'] != null) {
          users.add(UserModel.fromMap(item['memberId']));
        }
      }
      return users;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<List<UserModel>?> getPlayersByStage({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];
      final res = await HttpWrapper.getRequest(
          base_url + "player/players?stage=$stage&role=INTERNAL USER");
      final data = jsonDecode(res.body);
      Logger().w(data);
      for (var item in data['players']) {
        if (item != null) {
          users.add(UserModel.fromMap(item));
        }
      }
      return users;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<List<UserModel>?> getCoachesByStage({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];
      final userController = Get.find<UserController>();
      final res = await HttpWrapper.getRequest(base_url +
          "coach/all?stage=$stage&gameId=${userController.user!.gameId!.id}");
      final data = jsonDecode(res.body);
      for (var item in data['coaches']) {
        if (item != null) {
          users.add(UserModel.fromMap(item));
        }
      }
      return users;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future<List<UserModel>?> getCoachesByGame({
    required String stage,
  }) async {
    try {
      List<UserModel>? users = [];

      return users;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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

      //   final data = jsonDecode(res.body);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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

      //   final data = jsonDecode(res.body);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }

  Future updatePlayerStage({
    required String playerId,
    required String stage,
  }) async {
    try {
      final res =
          await HttpWrapper.postRequest(base_url + "coach/polarize-player", {
        "playerId": playerId,
        "stage": stage,
      });

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        Get.back();
        customSnackbar(data['message'], ContentType.success);
      } else {
        customSnackbar(data['error'], ContentType.failure);
      }
    } on ServerException catch (e) {
      //   await LoadingManager.endLoading();
      customSnackbar(e.message, ContentType.failure);
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
      for (var group in data['groups']) {
        groups.add(GroupModel.fromMap(group['groupId']));
      }

      return groups;
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
    return null;
  }
}
