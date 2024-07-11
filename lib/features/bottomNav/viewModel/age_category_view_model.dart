import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/repositories/age_category_repo.dart';
import 'package:fpdart/src/either.dart';

class AgeCategoryViewModel {
  AgeCategoryRepo ageCategoryRepo = AgeCategoryRepo();
  Future<List<AgeCategoryModel>> fetchAgeCategory() async {
    LoadingManager.startLoading();
    final res = await ageCategoryRepo.getAgeCategory();
    final val = switch (res) {
      Left(value: final l) => customSnackbar(message: l.message),
      Right(value: final r) => r
    };
    return val;
  }
}
