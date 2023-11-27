import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance_report/view/content/summery_tile.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shimmers.dart';

import '../../../bloc/report_bloc.dart';
import 'attendance_report/attendance_report_employee.dart';
import 'body_to_list_details.dart';

class AttendanceSummaryBody extends StatelessWidget {
  const AttendanceSummaryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (BuildContext context, state) {
        final summaryData = state.attendanceSummary?.data;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Summary'),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<ReportBloc>().add(SelectDate(context, false));
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                summaryData != null ? ListTile(
                  title: Text(
                    summaryData.date ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ) : const TileShimmer(titleHeight: 16,),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'On Time', type: 'on_time_in'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.onTimeIn,
                          title: 'on_time',
                          color: Colors.green),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'On Late', type: 'late_in'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.lateIn,
                          title: 'late',
                          color: Colors.red),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'Left Timely', type: 'left_timely'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.leftTimely,
                          title: 'left_timely',
                          color: Colors.green),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'On Left Early', type: 'left_early'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.leftEarly,
                          title: 'left_early',
                          color: Colors.red),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'On Leave', type: 'leave'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.leave,
                          title: 'on_leave',
                          color: Colors.grey[400]!),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'Absent', type: 'absent'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.absent,
                          title: 'absent',
                          color: Colors.black87),
                      SummeryTile(
                          onTap: () {
                            NavUtil.navigateScreen(
                              context,
                              BlocProvider.value(
                                value: context.read<ReportBloc>(),
                                child: const BodyToListDetails(
                                    title: 'Left Later', type: 'left_later'),
                              ),
                            );
                          },
                          titleValue:
                              summaryData?.attendanceSummary?.leftLater,
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
                    NavUtil.navigateScreen(
                      context,
                      BlocProvider.value(
                          value: context.read<ReportBloc>(),
                          child: const AttendanceReportEmployeeContent()),
                    );
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
          ),
        );
      },
    );
  }
}
