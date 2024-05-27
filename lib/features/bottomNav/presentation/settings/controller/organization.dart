import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/model/about.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  About? about;

  fetchOrganization() async {
    LoadingManager.startLoading();
    about = await ApiRequests().getOrganization();
    update();
  }
}
