import 'package:core/core.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/res/enum.dart';
import 'attendance_service.dart';

class AttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<AttendanceService>(attendanceService);
    instance.registerSingleton<AttendanceBlocFactory>(({required AttendanceType attendanceType, String? selfie}) =>
        AttendanceBloc(
            submitAttendanceUseCase: instance(), attendanceType: attendanceType, selfie: selfie, eventBus: instance()));
    instance.registerFactory<AttendancePageFactory>(() => (
            {required AttendanceBlocFactory attendanceBlocFactory,
            required AttendanceType attendanceType,
            String? selfie}) =>
        AttendancePage(
          attendanceBlocFactory: attendanceBlocFactory,
          attendanceType: attendanceType,
          selfie: selfie,
        ));
  }
}
