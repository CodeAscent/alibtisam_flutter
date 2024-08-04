import 'package:alibtisam/core/utils/loading_manager.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:get/get.dart';

class MeasurementReqController extends GetxController {
  List measurementRequests = [];

  Future fetchMeasurementRequests() async {
    measurementRequests = [];
    LoadingManager.startLoading();
    List data = await ApiRequests().getMesurementRequests();
    measurementRequests =
        data.where((request) => request['playerId'] != null).toList();
    update();
  }
}
