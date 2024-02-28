import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:onesthrm/page/home/home.dart';

class OnOfflineAttendanceUpdateEvent extends AppEvent{

  final AttendanceBody body;

  const OnOfflineAttendanceUpdateEvent({required this.body});

  @override
  List<Object?> get props => [body];

}