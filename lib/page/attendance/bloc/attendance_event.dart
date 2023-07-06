import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';

abstract class AttendanceEvent extends Equatable{

}

class OnLocationRefreshEvent extends AttendanceEvent{
  @override
  List<Object?> get props => [];
}

class OnLocationInitEvent extends AttendanceEvent{
  @override
  List<Object?> get props => [];
}


class OnRemoteModeChanged extends AttendanceEvent{
  final int mode;

  OnRemoteModeChanged({required this.mode});

  @override
  List<Object?> get props => [mode];
}

class OnAttendance extends AttendanceEvent{
  final DashboardModel homeData;

  OnAttendance({required this.homeData});

  @override
  List<Object?> get props => [homeData];
}