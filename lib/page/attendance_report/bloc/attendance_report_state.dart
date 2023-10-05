part of 'attendance_report_bloc.dart';

class AttendanceReportState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final AttendanceReport? attendanceReport;

  const AttendanceReportState({this.status, this.currentMonth, this.attendanceReport});

  AttendanceReportState copyWith(
      {NetworkStatus? status,
      Filter? filter,
      String? currentMonth,
      AttendanceReport? attendanceReport}) {
    return AttendanceReportState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        attendanceReport: attendanceReport ?? this.attendanceReport);
  }

  @override
  List<Object?> get props => [status, currentMonth, attendanceReport];
}
