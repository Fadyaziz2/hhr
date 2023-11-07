import 'package:equatable/equatable.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

class DailyLeaveState extends Equatable {
  final NetworkStatus? status;
  final DailyLeaveSummaryModel? dailyLeaveSummaryModel;
  final String? currentMonth;

  const DailyLeaveState(
      {this.status, this.dailyLeaveSummaryModel, this.currentMonth});

  DailyLeaveState copyWith(
      {NetworkStatus? status,
      DailyLeaveSummaryModel? dailyLeaveSummaryModel,
      String? currentMonth}) {
    return DailyLeaveState(
        status: status ?? this.status,
        dailyLeaveSummaryModel:
            dailyLeaveSummaryModel ?? this.dailyLeaveSummaryModel,
        currentMonth: currentMonth ?? this.currentMonth);
  }

  @override
  List<Object?> get props => [status, dailyLeaveSummaryModel, currentMonth];
}
