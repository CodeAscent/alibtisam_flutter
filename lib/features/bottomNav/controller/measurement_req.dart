import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
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
