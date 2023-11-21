part of 'report_bloc.dart';

class ReportState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final PhoneBookUser? selectEmployee;
  final ReportAttendanceSummary? attendanceSummary;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;

  const ReportState(
      {this.status,
      this.currentMonth,
      this.selectEmployee,
      this.attendanceSummary,
      this.leaveReportSummaryModel,
      this.filterLeaveSummaryResponse});

  ReportState copyWith({
    NetworkStatus? status,
    ReportAttendanceSummary? attendanceSummary,
    PhoneBookUser? selectEmployee,
    LeaveReportSummaryModel? leaveReportSummaryModel,
    LeaveSummaryModel? filterLeaveSummaryResponse,
    String? currentMonth,
  }) {
    return ReportState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        selectEmployee: selectEmployee ?? this.selectEmployee,
        attendanceSummary: attendanceSummary ?? this.attendanceSummary,
        leaveReportSummaryModel:
            leaveReportSummaryModel ?? this.leaveReportSummaryModel,
        filterLeaveSummaryResponse:
            filterLeaveSummaryResponse ?? this.filterLeaveSummaryResponse);
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        attendanceSummary,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse,
        selectEmployee
      ];
}
