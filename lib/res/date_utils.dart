import 'package:onesthrm/res/shared_preferences.dart';
import 'const.dart';


DateTime getDateTimeFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

Future<Duration?> getSyncDuration() async {
  final second =  await SharedUtil.getValue(breakTime);
  final duration = second != null ? getDuration(int.parse(second)) : null;
  return duration;
}

///return duration from current date time(by difference)
///we get how many days hours minutes seconds spanned from now
Duration getDuration(int timestamp) {
  var now = DateTime.now();
  var date = getDateTimeFromTimestamp(timestamp);
  return now.difference(date);
}