import 'dart:convert';

import 'package:SNP/core/error/server_exception.dart';
import 'package:SNP/core/utils/custom_snackbar.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/features/bottomNav/model/user.dart';
import 'package:SNP/network/api_urls.dart';
import 'package:SNP/network/http_wrapper.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/web.dart';

class PlayerByAgeAndStageRepo {
  Future<Either<ServerException, List<UserModel>>> getPlayersByAgeAndStage(
      {required String stage, required String ageCategoryId}) async {
    try {
      final res = await HttpWrapper.getRequest(players_by_age_and_stage +
          'players?stage=$stage&ageCategoryId=$ageCategoryId');
      final data = jsonDecode(res.body);
      List<UserModel> players = [];

      if (res.statusCode == 200) {
        for (var p in data['players']) {
          players.add(UserModel.fromMap(p));
        }
        Logger().w(players);

        return Right(players);
      } else {
        return Left(ServerException(data['message']));
      }
    } on ServerException catch (e) {
      await LoadingManager.endLoading();
      customSnackbar(message: e.message);
    }
    return Left(ServerException());
  }
}
