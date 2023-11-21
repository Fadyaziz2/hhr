part of 'leave_report_bloc.dart';

abstract class LeaveReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLeaveReportSummary extends LeaveReportEvent {
  GetLeaveReportSummary();

  @override
  List<Object> get props => [];
}

class FilterLeaveReportSummary extends LeaveReportEvent {
  final PhoneBookUser selectedEmployee;
  FilterLeaveReportSummary(this.selectedEmployee);

  @override
  List<Object> get props => [selectedEmployee];
}
