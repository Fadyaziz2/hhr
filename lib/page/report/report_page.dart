import 'package:flutter/material.dart';
import 'attendance_report_summary/view/content/report_content.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Summary'),),
        body: const ReportContent());
  }
}
