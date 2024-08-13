import 'package:alibtisam/core/error/server_exception.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/models/category_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/store/repo/category_repo.dart';
import 'package:get/get.dart';

class CategoryViewmodel extends GetxController {
  CategoryRepo categoryRepo = CategoryRepo();
  RxBool loading = false.obs;
  List<CategoryModel> categories = [];
  fetchStoreCategories() async {
    try {
      loading.value = true;
      final res = await categoryRepo.fetchStoreCategories();
      loading.value = false;

      categories = List<CategoryModel>.from(
        res['dropdown'].map(
          (e) => CategoryModel.fromJson(e),
        ),
      );
      categories.insert(0, CategoryModel('1', 'All'));

      update();
      return categories;
    } on ServerException catch (e) {
      customSnackbar(message: e.message);
    }
  }
}
