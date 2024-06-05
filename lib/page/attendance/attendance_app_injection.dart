import 'package:core/core.dart';
import 'package:onesthrm/page/bottom_navigation/view/bottom_navigation_page.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';

import 'attendance_service.dart';

class AttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<AttendanceService>(attendanceService);
  }
}
