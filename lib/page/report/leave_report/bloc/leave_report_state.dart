part of 'leave_report_bloc.dart';

class LeaveReportState extends Equatable {
  final NetworkStatus? status;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;
  final PhoneBookUser? selectedEmployeeName;

  const LeaveReportState({
    this.status,
    this.leaveReportSummaryModel,
    this.filterLeaveSummaryResponse,
    this.selectedEmployeeName,
  });

  LeaveReportState copyWith({
    NetworkStatus? status,
    ReportAttendanceSummary? attendanceSummary,
    LeaveReportSummaryModel? leaveReportSummaryModel,
    LeaveSummaryModel? filterLeaveSummaryResponse,
    PhoneBookUser? selectedEmployeeName,
  }) {
    return LeaveReportState(
        status: status ?? this.status,
        leaveReportSummaryModel:
            leaveReportSummaryModel ?? this.leaveReportSummaryModel,
        filterLeaveSummaryResponse:
            filterLeaveSummaryResponse ?? this.filterLeaveSummaryResponse,
        selectedEmployeeName:
            selectedEmployeeName ?? this.selectedEmployeeName);
  }

  @override
  List<Object?> get props => [
        status,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse,
        selectedEmployeeName,
      ];
}
