import 'package:intl/intl.dart';

customDateTimeFormat(String date) {
  return DateFormat('on dd MMMM yyyy HH:mm a').format(DateTime.parse(date));
}

customDateFormat(String date) {
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
}
