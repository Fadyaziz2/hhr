import 'package:flutter/material.dart';
import 'package:onesthrm/page/report/report.dart';

class AttendanceReportEmployeeContent extends StatelessWidget {
  const AttendanceReportEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance of Employee'),
      ),
      body: const Column(
        children: [
          SelectEmployeeForAttendance(),
        ],
      ),
    );
  }
}


