import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/models/tournament_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/repo/tournament_request_repo.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class TournamentRequestViewmodel extends GetxController {
  RxBool loading = false.obs;
  TournamentRequestRepo tournamentRequestRepo = TournamentRequestRepo();
  List<UserModel> players = [];
  List<UserModel> coaches = [];
  TournamentModel? tournament;
  List<dynamic> requestedTournaments = [];

  createTournamentRequest(
      {required String name,
      required String startDate,
      required String endDate,
      required String type,
      required String location,
      required String description,
      required String travelDate,
      required String transportMedium,
      required String expectedDeparture,
      required String expectedArrival,
      required String from,
      required String to,
      required String teamName,
      required List<String> playerIds,
      required List<String> coachIds,
      required int requestedAmount}) async {
    try {
      loading.value = true;
      final res = await tournamentRequestRepo.requestTorunament(
          name: name,
          startDate: startDate,
          endDate: endDate,
          type: type,
          location: location,
          description: description,
          travelDate: travelDate,
          transportMedium: transportMedium,
          expectedDeparture: expectedDeparture,
          expectedArrival: expectedArrival,
          from: from,
          to: to,
          teamName: teamName,
          playerIds: playerIds,
          coachIds: coachIds,
          requestedAmount: requestedAmount);

      loading.value = false;
      if (res.statusCode == 200) {
        Get.back();
      }
      final data = jsonDecode(res.body);
      customSnackbar(message: data['message']);
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }

  fetchPlayers() async {
    loading.value = true;
    players = [];
    players = (await ApiRequests().getPlayersByStage(stage: 'PROFESSIONAL'))!;
    loading.value = false;
    update();
  }

  fetchCoaches() async {
    loading.value = true;
    coaches = [];
    coaches = (await ApiRequests().getCoachesByStage(stage: 'PROFESSIONAL'))!;
    loading.value = false;
    update();
  }

  fetchTournamentRequests() async {
    try {
      loading.value = true;
      final res = await tournamentRequestRepo.fetchTournamentsRequests();

      loading.value = false;
      update();
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        requestedTournaments = data['requests'];
        return requestedTournaments;
      }

      return customSnackbar(message: data['message']);
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
      loading.value = false;
      customSnackbar(message: e.message);
    }
  }

  viewTournamentRequests({required String id}) async {
    try {
      loading.value = true;
      final res = await tournamentRequestRepo.fetchTournamentDataById(id: id);

      loading.value = false;
      update();
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        tournament = TournamentModel.fromMap(data['request']);
        update();
        return tournament;
      }

      return customSnackbar(message: data['message']);
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
      loading.value = false;
      customSnackbar(message: e.message);
    }
  }
}
