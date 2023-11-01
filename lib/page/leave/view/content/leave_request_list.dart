import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/no_data_found_widget.dart';
import '../../bloc/leave_bloc.dart';
import 'build_leave_title.dart';
import 'leave_list_shimmer.dart';

class LeaveRequestList extends StatelessWidget {
  const LeaveRequestList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: LeaveListShimmer(),
        );
      } else if (state.status == NetworkStatus.success) {
        return state.leaveRequestModel?.leaveRequestData?.leaveRequests
                    ?.isNotEmpty ==
                true
            ? ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.leaveRequestModel?.leaveRequestData
                        ?.leaveRequests?.length ??
                    0,
                itemBuilder: (context, index) {
                  LeaveRequestValue? leaveRequest = state.leaveRequestModel
                      ?.leaveRequestData?.leaveRequests?[index];
                  return BuildLeaveTitle(
                    leaveRequestValue: leaveRequest,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),
              )
            : const NoDataFoundWidget();
      } else if (state.status == NetworkStatus.failure) {
        return Center(
          child: Text(
            "Failed to load support list",
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
