import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/enum.dart';

typedef AttendancePageFactory = AttendancePage Function({required AttendanceBlocFactory attendanceBlocFactory,required AttendanceType attendanceType});

class AttendancePage extends StatelessWidget {
  final AttendanceBlocFactory attendanceBlocFactory;
  final AttendanceType attendanceType;
  final String? selfie;

  const AttendancePage({super.key, required this.attendanceBlocFactory, required this.attendanceType, this.selfie});

  static Route route({AttendanceType attendanceType = AttendanceType.normal, String? selfie}) {
    final homeBloc = instance<HomeBlocFactory>();
    final attendancePage = AttendancePage(
        attendanceType: attendanceType,
        selfie: selfie,
        attendanceBlocFactory: ({required AttendanceType attendanceType, String? selfie}) => AttendanceBloc(submitAttendanceUseCase: instance(), attendanceType: attendanceType, selfie: selfie)..add(OnLocationInitEvent(dashboardModel: homeBloc().state.dashboardModel)));
    return MaterialPageRoute(
      builder: (_) => attendancePage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: attendanceBlocFactory(attendanceType:attendanceType,selfie:selfie),
      child: Scaffold(
        body: AttendanceView(attendanceType: attendanceType),
      ),
    );
  }
}
