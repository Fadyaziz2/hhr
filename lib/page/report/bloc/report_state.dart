part of 'report_bloc.dart';

class ReportState extends Equatable {
  final NetworkStatus? status;
  final ReportAttendanceSummary? attendanceSummary;

  const ReportState({
    this.status,
    this.attendanceSummary,
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
    );
  }

  @override
  List<Object?> get props => [
        status,
        attendanceSummary,
      ];
}
