import 'package:flutter/material.dart';

import '../../../../../res/const.dart';
import '../../../../attendance_report/view/content/summery_tile.dart';

class AttendanceSummaryContent extends StatelessWidget {
  const AttendanceSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Summary'),
      ),
      body:  Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SummeryTile(
                      titleValue: '01 days',
                      title: 'working_days',
                      color: colorPrimary),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'on_time',
                      color: Colors.green),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'late',
                      color: Colors.red),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'left_timely',
                      color: Colors.green),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'left_early',
                      color: Colors.red),
                  SummeryTile(
                      titleValue: '12 days',
                      title: 'on_leave',
                      color: Colors.grey[400]!),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'absent',
                      color: Colors.black87),
                  const SummeryTile(
                      titleValue: '12 days',
                      title: 'left_later',
                      color: Colors.amber),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
