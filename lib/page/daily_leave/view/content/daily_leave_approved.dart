import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/model/leave_list_model.dart';
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
              NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<DailyLeaveBloc>(),
                    child: LeaveTypeScreen(
                      appBarName: "Early Leave",
                      leaveListData: LeaveListModel(
                          userId: user!.user!.id!.toString(),
                          month: dailyLeaveBloc.state.currentMonth ?? DateFormat('y-MM-d').format(DateTime.now()),
                          leaveStatus: 'approved',
                          leaveType:  "early_leave"),
                    )),
              );
            },
            title: 'Early Leave',
            value: approved?.earlyLeave.toString() ?? ''),
        DailyLeaveTile(
            onTap: () {
              NavUtil.navigateScreen(
                context,
                BlocProvider.value(
                    value: context.read<DailyLeaveBloc>(),
                    child: LeaveTypeScreen(
                      appBarName: "Early Leave",
                      leaveListData: LeaveListModel(
                          userId: user!.user!.id!.toString(),
                          month: dailyLeaveBloc.state.currentMonth ?? DateFormat('y-MM-d').format(DateTime.now()),
                          leaveStatus: 'approved',
                          leaveType:  "late_arrive"),
                    )),
              );
            },
            title: 'Late Leave',
            value: approved?.lateArrive.toString() ?? ''),
      ],
    );
  }
}
