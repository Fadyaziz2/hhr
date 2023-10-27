import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_state.dart';
import 'package:onesthrm/page/leave/view/content/build_leave_title.dart';
import 'package:onesthrm/page/leave/view/content/total_leave_count.dart';
import 'package:onesthrm/page/leave/view/leave_type/leave_request_type.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class LeaveSummaryContent extends StatelessWidget {
  final LeaveState? state;

  const LeaveSummaryContent({Key? key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        AnimatedCircularButton(
          onComplete: () {
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
        TotalLeaveCount(state: state),
        const Center(
            child: Text(
          "Leave Request",
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 20),
        )),
        const SizedBox(
          height: 25,
        ),
        state?.leaveRequestModel?.leaveRequestData?.leaveRequests?.isNotEmpty ==
                true
            ? ListView.separated(
                shrinkWrap: true,
                itemCount: state?.leaveRequestModel?.leaveRequestData
                        ?.leaveRequests?.length ??
                    0,
                itemBuilder: (context, index) {
                  return buildLeaveTitle();
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),
              )
            : const NoDataFoundWidget()
      ],
    );
  }
}
