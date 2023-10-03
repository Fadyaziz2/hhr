import 'package:flutter/material.dart';
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
            buildSummeryTile(
                titleValue: attendanceSummery?.workingDays ?? '',
                context: context,
                title: 'Working Days',
                color: colorPrimary),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalOnTimeIn ?? '',
                context: context,
                title: 'On Time',
                color: Colors.green),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalLateIn ?? '',
                context: context,
                title: 'Late',
                color: Colors.red),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalLeftTimely ?? '',
                context: context,
                title: 'Left Timely',
                color: Colors.green),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalLeftEarly ?? '',
                context: context,
                title: 'Left Early',
                color: Colors.red),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalLeave ?? '',
                context: context,
                title: 'On Leave',
                color: Colors.grey[400]!),
            buildSummeryTile(
                titleValue: attendanceSummery?.absent ?? '',
                context: context,
                title: 'Absent',
                color: Colors.black87),
            buildSummeryTile(
                titleValue: attendanceSummery?.totalLeftLater ?? '',
                context: context,
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
  Column buildSummeryTile(
      {required BuildContext context,
      required String title,
      required String titleValue,
      required Color color}) {
    return Column(
      children: [
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          leading: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          title: Text(title),
          trailing: Text(
            titleValue ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(
          height: 0.0,
          thickness: 1,
        )
      ],
    );
  }
}
