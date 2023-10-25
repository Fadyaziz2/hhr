import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveState extends Equatable {
  final NetworkStatus status;
  final LeaveSummaryModel? leaveSummaryModel;

  const LeaveState(
      {this.status = NetworkStatus.initial, this.leaveSummaryModel});

  LeaveState copyWith(
      {LeaveSummaryModel? leaveSummaryModel, NetworkStatus? status}) {
    return LeaveState(
        leaveSummaryModel: leaveSummaryModel ?? this.leaveSummaryModel);
  }

  @override
  List<Object?> get props => [status, leaveSummaryModel];
}
