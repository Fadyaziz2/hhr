import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_approved.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_pending.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_reject.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_select_employee.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../../res/const.dart';

class DailyLeaveStatusContent extends StatelessWidget {
  const DailyLeaveStatusContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
        builder: (context, state) {
      final bloc = context.read<DailyLeaveBloc>();
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
              /// Approved Leave =============
              ApplyDailySelectEmployee(bloc: bloc),

              /// Approved Leave ===============
              const DailyLeaveApproved(),

              /// pending Leave ===============
              const DailyLeavePending(),

              /// Rejected Leave ===============
              const DailyLeaveReject(),
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
