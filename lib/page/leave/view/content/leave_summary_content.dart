import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/view/content/leave_request_list.dart';
import 'package:onesthrm/page/leave/view/content/total_leave_count.dart';
import 'package:onesthrm/page/leave/view/leave_type/leave_request_type.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../bloc/leave_bloc.dart';

class LeaveSummaryContent extends StatelessWidget {
  final LeaveState? state;

  const LeaveSummaryContent({Key? key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Summary"),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<LeaveBloc>()
                    .add(SelectDatePicker(user!.user!.id!, context));
              },
              icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            AnimatedCircularButton(
              onComplete: () {
                NavUtil.navigateScreen(context, const LeaveRequestType());
              },
              title: "Apply Leave",
              color: colorPrimary,
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: const Text(
                "tab_to_apply_for_leave",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ).tr(),
            ),
            const SizedBox(
              height: 25,
            ),
            const TotalLeaveCount(),
            const Center(
                child: Text(
              "Leave Request",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            )),
            const SizedBox(
              height: 25,
            ),
            const LeaveRequestList()
          ],
        ),
      ),
    );
  }
}
