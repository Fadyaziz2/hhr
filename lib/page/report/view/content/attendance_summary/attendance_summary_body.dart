import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance_report/view/content/summery_tile.dart';
import 'package:onesthrm/page/report/report.dart';
import 'package:onesthrm/res/const.dart';

class AttendanceSummaryBody extends StatelessWidget {
  const AttendanceSummaryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (BuildContext context, state) {
        final summaryData = state.attendanceSummary?.data;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  summaryData?.date ?? "",style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   /*  SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.present ?? '',
                        title: 'working_days',
                        color: colorPrimary),*/
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.onTimeIn ?? '',
                        title: 'on_time',
                        color: Colors.green),
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.lateIn ?? '',
                        title: 'late',
                        color: Colors.red),
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.leftTimely ?? '',
                        title: 'left_timely',
                        color: Colors.green),
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.leftEarly ?? '',
                        title: 'left_early',
                        color: Colors.red),
                    SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.leave ?? '',
                        title: 'on_leave',
                        color: Colors.grey[400]!),
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.absent ?? '',
                        title: 'absent',
                        color: Colors.black87),
                     SummeryTile(
                        titleValue: summaryData?.attendanceSummary?.leftLater ?? '',
                        title: 'left_later',
                        color: Colors.amber),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // print("You pressed Icon Elevated Button");
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                //icon data for elevated button
                label: const Text(
                  "Search All Employee Attendance",
                  style: TextStyle(color: Colors.white),
                ),
                //label text
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(400, 50),
                    backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        );
      },
    );
  }
}
