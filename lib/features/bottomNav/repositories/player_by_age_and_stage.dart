import 'dart:convert';

import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/core/services/api_urls.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:fpdart/fpdart.dart';
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
