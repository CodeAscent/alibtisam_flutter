import 'package:SNP/features/bottomNav/presentation/settings/model/about.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  About? about;

  fetchOrganization() async {
    LoadingManager.startLoading();
    about = await ApiRequests().getOrganization();
    update();
  }
}
