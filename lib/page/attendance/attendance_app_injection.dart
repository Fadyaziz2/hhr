import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/bloc/bloc.dart';
import 'package:onesthrm/page/attendance/view/attendance_page.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/res/enum.dart';

import 'attendance_service.dart';
import 'bloc/attendance_bloc.dart';

class AttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<AttendanceService>(attendanceService);
    instance.registerSingleton<AttendanceBlocFactory>(({required AttendanceType attendanceType, String? selfie}) =>
        AttendanceBloc(submitAttendanceUseCase: instance(), attendanceType: attendanceType, selfie: selfie));
    instance.registerFactory<AttendancePageFactory>(() => ({required AttendanceBlocFactory attendanceBlocFactory,required AttendanceType attendanceType,String? selfie}) =>
        AttendancePage(attendanceBlocFactory: attendanceBlocFactory, attendanceType: attendanceType,selfie: selfie,));
  }
}
