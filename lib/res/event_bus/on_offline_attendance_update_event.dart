import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:onesthrm/page/home/home.dart';

class OnOnlineAttendanceUpdateEvent extends AppEvent{

  final AttendanceBody body;

  const OnOnlineAttendanceUpdateEvent({required this.body});

  @override
  List<Object?> get props => [body];

}

class OnOfflineAttendanceUpdateEvent extends AppEvent{

  final AttendanceBody body;

  const OnOfflineAttendanceUpdateEvent({required this.body});

  @override
  List<Object?> get props => [body];

}