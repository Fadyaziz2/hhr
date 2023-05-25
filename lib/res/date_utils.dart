import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String getDateAsString({required DateTime dateTime,String format = 'MM-dd-yyyy'}) {
  return DateFormat(format)
      .format(dateTime)
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
  return DateFormat('hh:mm a',).format(dateTime).toString();
}
