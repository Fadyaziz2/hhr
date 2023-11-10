import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class DailyLeaveApproved extends StatelessWidget {
  const DailyLeaveApproved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final approved = dailyLeaveBloc
        .state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.approved;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            "Approved Leave",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DailyLeaveTile(
            onTap: () {
              dailyLeaveBloc.add(LeaveTypeList(
                "early_leave",
                user!.user!.id!.toString(),
                'approved',
              ));
              NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<DailyLeaveBloc>(),
                    child: const LeaveTypeScreen(
                      appBarName: "Early Leave",
                    )),
              );
            },
            title: 'Early Leave',
            value: approved?.earlyLeave.toString() ?? ''),
        DailyLeaveTile(
            onTap: () {
              dailyLeaveBloc.add(LeaveTypeList("late_arrive", user!.user!.id!.toString(), 'approved',));
              NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<DailyLeaveBloc>(),
                    child: const LeaveTypeScreen(
                      appBarName: "Early Leave",
                    )),
              );
            },
            title: 'Late Leave',
            value: approved?.lateArrive.toString() ?? ''),
      ],
    );
  }
}
