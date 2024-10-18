import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/clinic/models/injured_player_model.dart';
import 'package:alibtisam/features/clinic/repo/injured_player_repo.dart';

class InjuredPlayerViewmodel {
  final InjuredPlayerRepo injuredPlayerRepo;

  InjuredPlayerViewmodel({required this.injuredPlayerRepo});

  Future getInjuredPlayers() async {
    try {
      final res = await injuredPlayerRepo.getInjuredPlayers();
      if (res != null) {
        return List<InjuredPlayerModel>.from(
            res['data'].map((e) => InjuredPlayerModel.fromMap(e)));
      } else {
        customSnackbar(res['message'], ContentType.failure);
      }
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    }
  }

  
}
