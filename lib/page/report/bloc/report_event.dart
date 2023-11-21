part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReportData extends ReportEvent {
  GetReportData();

  @override
  List<Object> get props => [];
}

class GetLeaveReportSummary extends ReportEvent {
  GetLeaveReportSummary();

  @override
  List<Object> get props => [];
}

class FilterLeaveReportSummary extends ReportEvent {
  final PhoneBookUser selectedEmployee;
  FilterLeaveReportSummary(this.selectedEmployee);

  @override
  List<Object> get props => [selectedEmployee];
}
