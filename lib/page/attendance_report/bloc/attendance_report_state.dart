part of 'attendance_report_bloc.dart';

class AttendanceReportState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;

  const AttendanceReportState({
    this.status,
    this.currentMonth,
  });

  AttendanceReportState copy({
    NetworkStatus? status,
    Filter? filter,
    String? currentMonth,
  }) {
    return AttendanceReportState(
      status: status ?? this.status,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
      ];
}
