import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class DailyLeaveReject extends StatelessWidget {
  const DailyLeaveReject({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final rejected = dailyLeaveBloc.state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.rejected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            "Rejected Leave",
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
                'rejected',
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
            value: rejected?.earlyLeave.toString() ?? ''),
        DailyLeaveTile(
            onTap: () {
              context.read<DailyLeaveBloc>().add(LeaveTypeList("late_arrive", user!.user!.id!.toString(), 'rejected'));
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
            value: rejected?.lateArrive.toString() ?? ''),
      ],
    );
  }
}
