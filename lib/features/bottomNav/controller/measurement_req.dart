import 'package:SNP/core/utils/loading_manager.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:get/get.dart';

class MeasurementReqController extends GetxController {
  List measurementRequests = [];

  Future fetchMeasurementRequests() async {
    measurementRequests = [];
    LoadingManager.startLoading();
    measurementRequests = await ApiRequests().getMesurementRequests();
    update();
  }
}
