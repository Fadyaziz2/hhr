import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../../res/const.dart';

class DailyLeaveStatusContent extends StatelessWidget {
  const DailyLeaveStatusContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
        builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: LeaveListShimmer(),
        );
      } else if (state.status == NetworkStatus.success) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Approved Leave",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              DailyLeaveTile(
                  title: 'Early Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.approved?.earlyLeave
                          .toString() ??
                      ''),
              DailyLeaveTile(
                  title: 'Late Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.approved?.lateArrive
                          .toString() ??
                      ''),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Rejected Leave",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              DailyLeaveTile(
                  title: 'Early Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.rejected?.earlyLeave
                          .toString() ??
                      ''),
              DailyLeaveTile(
                  title: 'Late Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.rejected?.lateArrive
                          .toString() ??
                      ''),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Pending Leave",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              DailyLeaveTile(
                  title: 'Early Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.pending?.earlyLeave
                          .toString() ??
                      ''),
              DailyLeaveTile(
                  title: 'Late Leave',
                  value: state.dailyLeaveSummaryModel?.dailyLeaveSummaryData
                          ?.pending?.lateArrive
                          .toString() ??
                      ''),
            ],
          ),
        );
      } else if (state.status == NetworkStatus.failure) {
        return Center(
          child: Text(
            "Failed to load Leave list",
            style: TextStyle(
                color: colorPrimary.withOpacity(0.4),
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
