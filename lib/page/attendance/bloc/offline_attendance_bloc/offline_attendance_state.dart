import 'package:equatable/equatable.dart';
import 'package:onesthrm/page/home/home.dart';

class OfflineAttendanceState extends Equatable {
  final bool isCheckedIn;
  final bool isCheckedOut;
  final AttendanceBody? attendanceBody;

  const OfflineAttendanceState({
    this.isCheckedIn = false,
    this.isCheckedOut = false,
    this.attendanceBody,
  });

  OfflineAttendanceState copyWith(
      {bool? isCheckedIn, bool? isCheckedOut, AttendanceBody? attendanceBody}) {
    return OfflineAttendanceState(
        isCheckedIn: isCheckedIn ?? this.isCheckedIn,
        isCheckedOut: isCheckedOut ?? this.isCheckedOut,
        attendanceBody: attendanceBody ?? this.attendanceBody);
  }

  @override
  List<Object?> get props => [isCheckedIn, isCheckedOut,attendanceBody];
}
