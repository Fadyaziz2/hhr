import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class DailyLeavePending extends StatelessWidget {
  const DailyLeavePending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final pending = dailyLeaveBloc.state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.pending;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              dailyLeaveBloc.add(LeaveTypeList(
                "early_leave",
                user!.user!.id!.toString(),
                'pending',
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
            value: pending?.earlyLeave.toString() ?? ''),
        DailyLeaveTile(
            onTap: () {
              dailyLeaveBloc.add(LeaveTypeList(
                "late_arrive",
                user!.user!.id!.toString(),
                'pending',
              ));
              NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<DailyLeaveBloc>(),
                    child: const LeaveTypeScreen(
                      appBarName: "Late Leave",
                    )),
              );
            },
            title: 'Late Leave',
            value: pending?.lateArrive.toString() ?? ''),
      ],
    );
  }
}