import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_screen.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../../../res/const.dart';

class DailyLeaveStatusContent extends StatelessWidget {
  const DailyLeaveStatusContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
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
              Card(
                child: ListTile(
                  onTap: () async {
                    PhoneBookUser employee = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectEmployeePage(),
                        ));
                    // ignore: use_build_context_synchronously
                    context
                        .read<DailyLeaveBloc>()
                        // ignore: use_build_context_synchronously
                        .add(SelectEmployee(employee));
                  },
                  title: Text(state.selectEmployee?.name! ?? 'Select Employee'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(state
                            .selectEmployee?.avatar ??
                        'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  "Approved Leave",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
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
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  "Rejected Leave",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
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
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  "Pending Leave",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              DailyLeaveTile(
                  onTap: () {
                    context.read<DailyLeaveBloc>().add(LeaveTypeList(
                          state.currentMonth,
                          "early_leave",
                          state.selectEmployee?.id.toString() ??
                              user?.user?.id.toString(),
                          'pending',
                        ));
                    NavUtil.navigateScreen(
                        context,
                        BlocProvider.value(
                            value: context.read<DailyLeaveBloc>(),
                            child: const LeaveTypeScreen(
                              appBarName: "Early Leave",
                            )));
                  },
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
