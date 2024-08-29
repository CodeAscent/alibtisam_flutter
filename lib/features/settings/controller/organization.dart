import 'package:alibtisam/features/settings/model/about.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  About? about;

  fetchOrganization() async {
    about = await ApiRequests().getOrganization();
    update();
  }
}
