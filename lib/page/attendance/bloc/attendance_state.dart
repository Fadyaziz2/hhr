import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class AttendanceState extends Equatable {
  final NetworkStatus status;
  final bool locationLoaded;
  final DashboardModel? dashboardModel;
  final CheckData? checkInOut;
  final String? location;

  const AttendanceState({this.status = NetworkStatus.initial,this.locationLoaded = true, this.dashboardModel, this.checkInOut, this.location});

  AttendanceState copyWith(
      {NetworkStatus? status,
      DashboardModel? dashboardModel,
        CheckData? checkInOut,
      String? location}) {
    return AttendanceState(
        status: status ?? this.status,
        dashboardModel: dashboardModel ?? this.dashboardModel,
        checkInOut: checkInOut ?? this.checkInOut,
        location: location ?? this.location);
  }

  @override
  List<Object?> get props => [status, dashboardModel, location, checkInOut];
}
