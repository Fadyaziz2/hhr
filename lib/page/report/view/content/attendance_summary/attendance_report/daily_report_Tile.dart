import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/report.dart';

class DailyReportTile extends StatelessWidget {
  const DailyReportTile({super.key});

  @override
  Widget build(BuildContext context) {
    final reportBloc = context.watch<ReportBloc>();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reportBloc.state.attendanceReport?.reportData?.dailyReport?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final data = reportBloc.state.attendanceReport?.reportData?.dailyReport?[index];
        return SummaryOfDailyReportListTile(dailyReport: data!, isReportSummary: true,);
      },
    );
  }
}
