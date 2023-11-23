import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class AttendanceState extends Equatable {
  final NetworkStatus status;
  final ActionStatus actionStatus;
  final bool locationLoaded;
  final DashboardModel? dashboardModel;
  final CheckData? checkData;
  final String? location;

  const AttendanceState({this.status = NetworkStatus.initial,this.locationLoaded = true, this.dashboardModel, this.checkData, this.location,this.actionStatus = ActionStatus.checkInOut});

  AttendanceState copyWith(
      {
        NetworkStatus? status,
        ActionStatus? actionStatus,
      DashboardModel? dashboardModel,
        CheckData? checkData,
        bool? locationLoaded,
      String? location}) {
    return AttendanceState(
        status: status ?? this.status,
        actionStatus: actionStatus ?? this.actionStatus,
        locationLoaded: locationLoaded ?? this.locationLoaded,
        dashboardModel: dashboardModel ?? this.dashboardModel,
        checkData: checkData ?? this.checkData,
        location: location ?? this.location);
  }

  @override
  List<Object?> get props => [status, dashboardModel, location, checkData,locationLoaded,actionStatus];
}
