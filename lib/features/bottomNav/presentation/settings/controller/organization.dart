import 'package:alibtisam/features/bottomNav/presentation/settings/model/about.dart';
import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  About? about;

  fetchOrganization() async {
    LoadingManager.startLoading();
    about = await ApiRequests().getOrganization();
    update();
  }
}
