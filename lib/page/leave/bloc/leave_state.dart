import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveState extends Equatable {
  final NetworkStatus status;
  final LeaveSummaryModel? leaveSummaryModel;
  final LeaveRequestModel? leaveRequestModel;

  const LeaveState(
      {this.status = NetworkStatus.initial, this.leaveSummaryModel,this.leaveRequestModel});

  LeaveState copyWith(
      {LeaveSummaryModel? leaveSummaryModel, NetworkStatus? status,LeaveRequestModel? leaveRequestModel}) {
    return LeaveState(
        leaveSummaryModel: leaveSummaryModel ?? this.leaveSummaryModel,leaveRequestModel: this.leaveRequestModel);
  }

  @override
  List<Object?> get props => [status, leaveSummaryModel,leaveRequestModel];
}
