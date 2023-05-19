import 'package:intl/intl.dart';

String getDateAsString({required DateTime dateTime,String format = 'MM-dd-yyyy'}) {
  return DateFormat(format)
      .format(dateTime)
      .toString();
}

DateTime? getFormattedDateTime({required String? date,String format = 'MM-dd-yyyy'}) {

  DateFormat formatter = DateFormat(format,'en');

  return date != null ? formatter.parse(date) : null;
}

String? getDateddMMMyyyyString({DateTime? dateTime}) {
  return dateTime != null ? DateFormat('dd MMM yyyy')
      .format(dateTime)
      .toString() : null;
}

String getTimeAmPm(DateTime dateTime) {
  return DateFormat('hh:mm a',).format(dateTime).toString();
}
