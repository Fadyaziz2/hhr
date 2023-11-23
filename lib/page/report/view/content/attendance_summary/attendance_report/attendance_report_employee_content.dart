import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/report.dart';

class AttendanceReportEmployeeContent extends StatelessWidget {
  const AttendanceReportEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ReportBloc, ReportState>(
      builder: (BuildContext context, state) {
        context.read<ReportBloc>().add(GetAttendanceReportData());
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance of Employee'),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<ReportBloc>().add(SelectDate(context, true));
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SelectEmployeeForAttendance(),
                  const AttendanceSummaryTile(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                        tr('daily_report'),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const DailyReportTile()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
