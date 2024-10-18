import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/tournamentRequest/models/tournament_model.dart';
import 'package:alibtisam/features/tournamentRequest/repo/tournament_request_repo.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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
      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        customSnackbar(data['message'], ContentType.success);

        Get.back();
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
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
      } else {
        customSnackbar(data['message'], ContentType.failure);
      }
    } on ServerException catch (e) {
      loading.value = false;
      customSnackbar(e.message, ContentType.failure);
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

      customSnackbar(data['message'], ContentType.success);
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
      loading.value = false;
    }
  }

  Future addReceipt({
    required String id,
    required String title,
    required String amount,
    required String description,
    required XFile invoiceImage,
  }) async {
    try {
      final response = await tournamentRequestRepo.addReceipt(
          id: id,
          title: title,
          amount: amount,
          description: description,
          invoiceImage: invoiceImage);
      final res = await response.stream.bytesToString();
      final data = jsonDecode(res);
      Logger().w(data);

      if (data["success"] == false) {
        customSnackbar(data["message"], ContentType.failure);
      } else {
        customSnackbar(data["message"], ContentType.success);
      }
    } on ServerException catch (e) {
      customSnackbar(e.message, ContentType.failure);
    }
  }
}
