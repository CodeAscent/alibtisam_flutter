import 'package:intl/intl.dart';

dateFormat(String date) {
  return DateFormat('on dd MMMM yyyy HH:mm a').format(DateTime.parse(date));
}
