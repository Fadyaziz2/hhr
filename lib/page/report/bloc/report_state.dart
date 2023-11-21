part of 'report_bloc.dart';

class ReportState extends Equatable {
  final NetworkStatus? status;
  final ReportAttendanceSummary? attendanceSummary;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;
  final PhoneBookUser? selectedEmployeeName;

  const ReportState({
    this.status,
    this.attendanceSummary,
    this.leaveReportSummaryModel,
    this.filterLeaveSummaryResponse,
    this.selectedEmployeeName,
  });

  ReportState copyWith({
    NetworkStatus? status,
    ReportAttendanceSummary? attendanceSummary,
    LeaveReportSummaryModel? leaveReportSummaryModel,
    LeaveSummaryModel? filterLeaveSummaryResponse,
    PhoneBookUser? selectedEmployeeName,
  }) {
    return ReportState(
        status: status ?? this.status,
        attendanceSummary: attendanceSummary ?? this.attendanceSummary,
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
        attendanceSummary,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse,
        selectedEmployeeName,
      ];
}
