import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class DailyLeaveState extends Equatable {
  final NetworkStatus? status;
  final DailyLeaveSummaryModel? dailyLeaveSummaryModel;

  const DailyLeaveState({this.status, this.dailyLeaveSummaryModel});

  DailyLeaveState copyWith(
      {NetworkStatus? status, DailyLeaveSummaryModel? dailyLeaveSummaryModel}) {
    return DailyLeaveState(
        status: status ?? this.status,
        dailyLeaveSummaryModel:
            dailyLeaveSummaryModel ?? this.dailyLeaveSummaryModel);
  }

  @override
  List<Object?> get props => [status, dailyLeaveSummaryModel];
}
