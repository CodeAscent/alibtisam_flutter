import 'package:intl/intl.dart';

customDateTimeFormat(String date) {
  return DateFormat('on dd MMMM yyyy HH:mm a')
      .format(DateTime.parse(date).toLocal());
}

customTimeFormat(String date) {
  return DateFormat(' HH:mm a').format(DateTime.parse(date).toLocal());
}

customDateFormat(String date) {
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(date).toLocal());
}
customDateMMMFormat(String date) {
  return DateFormat('yyyy MMM dd').format(DateTime.parse(date).toLocal());
}


customChatDateFormat(String date) {
  return DateFormat('dd MMM').format(DateTime.parse(date).toLocal());
}

customChatTimeFormat(String date) {
  return DateFormat('HH:mm a').format(DateTime.parse(date).toLocal());
}
