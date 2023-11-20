part of 'report_bloc.dart';

class ReportState extends Equatable {
  final NetworkStatus? status;
  final ReportAttendanceSummary? attendanceSummary;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;

  const ReportState(
      {this.status,
      this.attendanceSummary,
      this.leaveReportSummaryModel,
      this.filterLeaveSummaryResponse});

  ReportState copyWith({
    NetworkStatus? status,
    ReportAttendanceSummary? attendanceSummary,
    LeaveReportSummaryModel? leaveReportSummaryModel,
    LeaveSummaryModel? filterLeaveSummaryResponse,
  }) {
    return ReportState(
        status: status ?? this.status,
        attendanceSummary: attendanceSummary ?? this.attendanceSummary,
        leaveReportSummaryModel:
            leaveReportSummaryModel ?? this.leaveReportSummaryModel,
        filterLeaveSummaryResponse:
            filterLeaveSummaryResponse ?? this.filterLeaveSummaryResponse);
  }

  @override
  List<Object?> get props => [
        status,
        attendanceSummary,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse
      ];
}
