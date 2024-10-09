import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/sports/available_sports.dart';
import 'package:alibtisam/features/sports/models/club_sport.dart';
import 'package:alibtisam/features/sports/repo/sports_repo.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';

class SportsViewmodel extends GetxController {
  final SportsRepo sportsRepo;

  SportsViewmodel(this.sportsRepo);
  List<ClubSport> clubSports = [];
  RxBool isLoading = false.obs;
  Future getClubSports() async {
    try {
      isLoading.value = true;
      final res = await sportsRepo.getClubSports();
      if (res != null) {
        clubSports =
            List<ClubSport>.from(res['games'].map((e) => ClubSport.fromMap(e)));
      }
      update();
    } catch (e) {
      customSnackbar(e.toString(), ContentType.failure);
    } finally {
      isLoading.value = false; // Stop loading after the operation
    }
  }
}
