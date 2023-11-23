part of 'leave_report_bloc.dart';

class LeaveReportState extends Equatable {
  final NetworkStatus? status;
  final LeaveReportSummaryModel? leaveReportSummaryModel;
  final LeaveSummaryModel? filterLeaveSummaryResponse;
  final LeaveRequestModel? leaveRequestModel;
  final PhoneBookUser? selectedEmployeeName;
  final String? selectMonth;
  final String? selectUserId;
  final PhoneBookUser? selectedEmployee;

  const LeaveReportState({
    this.status,
    this.leaveReportSummaryModel,
    this.filterLeaveSummaryResponse,
    this.selectedEmployeeName,
    this.leaveRequestModel,
    this.selectMonth,
    this.selectUserId,
    this.selectedEmployee,
  });

  LeaveReportState copyWith({
    NetworkStatus? status,
    ReportAttendanceSummary? attendanceSummary,
    LeaveReportSummaryModel? leaveReportSummaryModel,
    LeaveSummaryModel? filterLeaveSummaryResponse,
    PhoneBookUser? selectedEmployeeName,
    LeaveRequestModel? leaveRequestModel,
    String? selectMonth,
    PhoneBookUser? selectedEmployee,
    String? selectUserId,
  }) {
    return LeaveReportState(
      status: status ?? this.status,
      leaveReportSummaryModel:
          leaveReportSummaryModel ?? this.leaveReportSummaryModel,
      filterLeaveSummaryResponse:
          filterLeaveSummaryResponse ?? this.filterLeaveSummaryResponse,
      selectedEmployeeName: selectedEmployeeName ?? this.selectedEmployeeName,
      leaveRequestModel: leaveRequestModel ?? this.leaveRequestModel,
      selectMonth: selectMonth ?? this.selectMonth,
      selectedEmployee: selectedEmployee ?? this.selectedEmployee,
      selectUserId: selectUserId ?? this.selectUserId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        leaveReportSummaryModel,
        filterLeaveSummaryResponse,
        selectedEmployeeName,
        leaveRequestModel,
        selectedEmployee,
        selectUserId,
      ];
}
