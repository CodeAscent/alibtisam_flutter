import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/repositories/player_by_age_and_stage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class PlayersByAgeAndStageViewmodel {
  PlayerByAgeAndStageRepo playerByAgeAndStageRepo = PlayerByAgeAndStageRepo();
  Future<List<UserModel>> fetchPlayersByAgeAndStage(
      {required String stage, required String ageCategoryId}) async {
    Logger().w(stage);
    final res = await playerByAgeAndStageRepo.getPlayersByAgeAndStage(
        stage: stage, ageCategoryId: ageCategoryId);
    final val = switch (res) {
      Right(value: final r) => r,
      Left(value: final l) => customSnackbar(message: l.message)
    };
    return val;
  }
}
