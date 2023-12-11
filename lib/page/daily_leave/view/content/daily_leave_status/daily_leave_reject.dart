import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/model/leave_list_model.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_tile.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class DailyLeaveReject extends StatelessWidget {
  const DailyLeaveReject({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    final rejected = dailyLeaveBloc
        .state.dailyLeaveSummaryModel?.dailyLeaveSummaryData?.rejected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            "rejected_leave".tr(),
            style: const TextStyle(
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
                  appBarName: "early_leave".tr(),
                  leaveListData: LeaveListModel(
                      userId: user!.user!.id!.toString(),
                      month: dailyLeaveBloc.state.currentMonth ??
                          DateFormat('y-MM-d').format(DateTime.now()),
                      leaveStatus: 'rejected',
                      leaveType: "early_leave"),
                ),
              ),
            );
          },
          title: 'early_leave'.tr(),
          value: rejected?.earlyLeave.toString() ?? '',
          color: Colors.red,
        ),
        DailyLeaveTile(
          onTap: () {
            NavUtil.navigateScreen(
              context,
              BlocProvider.value(
                  value: context.read<DailyLeaveBloc>(),
                  child: LeaveTypeScreen(
                    appBarName: "late_leave".tr(),
                    leaveListData: LeaveListModel(
                        userId: user!.user!.id!.toString(),
                        month: dailyLeaveBloc.state.currentMonth ??
                            DateFormat('y-MM-d').format(DateTime.now()),
                        leaveStatus: 'rejected',
                        leaveType: "late_arrive"),
                  )),
            );
          },
          title: 'late_leave'.tr(),
          value: rejected?.lateArrive.toString() ?? '',
          color: Colors.red,
        ),
      ],
    );
  }
}
