import 'package:get/get.dart';

class DateRangeController extends GetxController {
  List<DateTime?>? dates = [];
  setDates(List<DateTime?>? val) {
    dates = val;
    update();
  }

  clearDates() {
    dates!.clear();
    update();
  }
}
