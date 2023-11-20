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
  final int selectedEmployeeId;
  FilterLeaveReportSummary(this.selectedEmployeeId);

  @override
  List<Object> get props => [selectedEmployeeId];
}

class SelectDate extends ReportEvent {
  final BuildContext context;
  SelectDate(this.context);

  @override
  List<Object> get props => [];
}

