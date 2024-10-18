import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/bottomNav/repositories/player_by_age_and_stage.dart';
import 'package:fpdart/fpdart.dart';

class PlayersByAgeAndStageViewmodel {
  PlayerByAgeAndStageRepo playerByAgeAndStageRepo = PlayerByAgeAndStageRepo();
  Future<List<UserModel>> fetchPlayersByAgeAndStage(
      {required String stage, required String ageCategoryId}) async {
    final res = await playerByAgeAndStageRepo.getPlayersByAgeAndStage(
        stage: stage, ageCategoryId: ageCategoryId);
    final val = switch (res) {
      Right(value: final r) => r,
      Left(value: final l) => customSnackbar(l.message, ContentType.failure)
    };
    return val;
  }
}
