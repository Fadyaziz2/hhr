import 'package:core/core.dart';

import 'attendance_service.dart';

class AttendanceInjection {
  Future<void> initInjection() async {
    instance.registerSingleton<AttendanceService>(attendanceService);
  }
}
