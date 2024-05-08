import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


String getDateAsString({ DateTime ? dateTime,String format = 'MM-dd-yyyy'}) {
  return DateFormat(format)
      .format(dateTime!)
      .toString();
}

DateTime? getFormattedDateTime({required String date,String format = 'MM-dd-yyyy'}) {

  try{
    DateFormat formatter = DateFormat(format);
    return date != 'N/A' ? formatter.parse(date) : null;
  } on FormatException catch(e){
    debugPrint(e.toString());
  }
  return null;
}

String? getDateddMMMyyyyString({DateTime? dateTime}) {
  return dateTime != null ? DateFormat('dd MMM yyyy')
      .format(dateTime)
      .toString() : null;
}

String? getDDMMYYYYAsString({required String date, String outputFormat = 'yyyy-mm-dd',String inputFormat = 'dd-mm-yyyy'}) {
  try{
    DateFormat formatter = DateFormat(inputFormat);
    DateFormat outputFormatter = DateFormat(outputFormat);
    return outputFormatter.format(formatter.parse(date));
  } on FormatException catch(e){
    debugPrint(e.toString());
  }
  return null;
}

String getTimeAmPm(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime).toString();
}

DateTime getDateTimeFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

///return duration from current date time(by difference)
///we get how many days hours minutes seconds spanned from now
Duration getDuration(int timestamp) {
  var now = DateTime.now();
  var date = getDateTimeFromTimestamp(timestamp);
  return now.difference(date);
}

List<int> normalizeSeconds(int seconds) {
  int days = seconds ~/ TimeConstants.secondsPerDay;
  seconds -= days * TimeConstants.secondsPerDay;
  int hours = seconds ~/ TimeConstants.secondsPerHour;
  seconds -= hours * TimeConstants.secondsPerHour;
  int minutes = seconds ~/ TimeConstants.secondPerMinute;
  seconds -= minutes * TimeConstants.secondPerMinute;
  return [days, hours, minutes, seconds];
}
