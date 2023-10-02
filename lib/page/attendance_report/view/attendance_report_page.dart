import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance/bloc/attendance_bloc.dart';
import 'package:onesthrm/page/attendance_report/view/content/content.dart';

class AttendanceReportPage extends StatelessWidget {
  final AttendanceBloc attendanceBloc;

  const AttendanceReportPage({Key? key, required this.attendanceBloc})
      : super(key: key);

  static Route route({required AttendanceBloc attendanceBloc}) {
    return MaterialPageRoute(
        builder: (_) => AttendanceReportPage(
              attendanceBloc: attendanceBloc,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Report'),
      ),
      body: ListView(
        children: [
          const AttendanceReportContent(),
        ],
      ),
    );
  }
}
