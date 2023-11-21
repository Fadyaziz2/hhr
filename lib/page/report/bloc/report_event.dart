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

class SelectDate extends ReportEvent {
  final BuildContext context;
  SelectDate(this.context);

  @override
  List<Object> get props => [];
}

class SelectEmployee extends ReportEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class GetAttendanceReportData extends ReportEvent {
  final int userId;
  GetAttendanceReportData(this.userId);

  @override
  List<Object> get props => [userId];
}

