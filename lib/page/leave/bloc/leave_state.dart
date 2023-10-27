import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveState extends Equatable {
  final NetworkStatus status;
  final LeaveSummaryModel? leaveSummaryModel;
  final LeaveRequestModel? leaveRequestModel;
  final LeaveRequestTypeModel? leaveRequestType;

  const LeaveState(
      {this.status = NetworkStatus.initial, this.leaveSummaryModel,this.leaveRequestModel,this.leaveRequestType});

  LeaveState copyWith(
      {LeaveSummaryModel? leaveSummaryModel, NetworkStatus? status,LeaveRequestModel? leaveRequestModel,LeaveRequestTypeModel? leaveRequestType}) {
    return LeaveState(
        leaveSummaryModel: leaveSummaryModel ?? this.leaveSummaryModel,leaveRequestModel: leaveRequestModel ?? this.leaveRequestModel,leaveRequestType: leaveRequestType ?? this.leaveRequestType);
  }

  @override
  List<Object?> get props => [status, leaveSummaryModel,leaveRequestModel,leaveRequestType];
}
