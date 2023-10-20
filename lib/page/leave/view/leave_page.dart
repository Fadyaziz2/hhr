import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/page/leave/view/leave_type/leave_request_type.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'content/build_leave_title.dart';
import 'content/total_leave_count.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave Summary"),
        actions: [
          IconButton(
              onPressed: () {
                // context.read<SupportBloc>().add(SelectDatePicker(context));

              },
              icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          AnimatedCircularButton(
            onComplete: () {
              // context
              //     .read<AttendanceBloc>()
              //     .add(OnAttendance(homeData: homeData!));
              NavUtil.replaceScreen(context, const LeaveRequestType());
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
          ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return buildLeaveTitle();
              })
        ],
      ),
    );
  }
}
