import 'package:intl/intl.dart';

customDateTimeFormat(String date) {
  return DateFormat('on dd MMMM yyyy HH:mm a').format(DateTime.parse(date));
}

customDateFormat(String date) {
  return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
}
