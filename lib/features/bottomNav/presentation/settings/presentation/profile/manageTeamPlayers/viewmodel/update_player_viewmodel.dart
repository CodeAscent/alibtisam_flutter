import 'package:SNP/core/utils/custom_snackbar.dart';
import 'package:SNP/features/bottomNav/presentation/settings/presentation/profile/manageTeamPlayers/repository/update_player_remote.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class UpdatePlayerViewmodel {
  UpdatePlayerRemote updatePlayerRemote = UpdatePlayerRemote();
  Future updateUserById(
      {required String uid, required Map<String, String> body}) async {
    final res = await updatePlayerRemote.updateUserById(uid: uid, body: body);
    final val = switch (res) {
      Left(value: final l) => customSnackbar(message: l.message),
      Right(value: final r) => customSnackbar(message: r)
    };
    print(val);
  }
}
