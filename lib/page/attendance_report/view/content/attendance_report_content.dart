import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance_report/view/content/summery_tile.dart';
import 'package:onesthrm/res/const.dart';
import '../../bloc/bloc.dart';

class AttendanceReportContent extends StatelessWidget {
  const AttendanceReportContent({Key? key, required this.bloc})
      : super(key: key);
  final AttendanceReportBloc bloc;

  @override
  Widget build(BuildContext context) {
    final attendanceSummery =
        bloc.state.attendanceReport?.reportData?.attendanceSummary;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Column(
          children: [
            SummeryTile(
                titleValue: attendanceSummery?.workingDays ?? '',
                title: 'Working Days',
                color: colorPrimary),
            SummeryTile(
                titleValue: attendanceSummery?.totalOnTimeIn ?? '',
                title: 'On Time',
                color: Colors.green),
            SummeryTile(
                titleValue: attendanceSummery?.totalLateIn ?? '',
                title: 'Late',
                color: Colors.red),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftTimely ?? '',
                title: 'Left Timely',
                color: Colors.green),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftEarly ?? '',
                title: 'Left Early',
                color: Colors.red),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeave ?? '',
                title: 'On Leave',
                color: Colors.grey[400]!),
            SummeryTile(
                titleValue: attendanceSummery?.absent ?? '',
                title: 'Absent',
                color: Colors.black87),
            SummeryTile(
                titleValue: attendanceSummery?.totalLeftLater ?? '',
                title: 'Left Later',
                color: Colors.amber),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
