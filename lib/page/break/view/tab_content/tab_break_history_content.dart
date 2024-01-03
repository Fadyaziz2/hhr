import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../res/const.dart';
import '../../../app/global_state.dart';
import '../../../leave/view/content/leave_list_shimmer.dart';

class TabBreakHistoryContent extends StatelessWidget {
  final DashboardModel? dashboard;
  final BreakState state;

  const TabBreakHistoryContent(
      {super.key, required this.state, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    if (state.status == NetworkStatus.loading) {
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            Shimmer.fromColors(
              baseColor: const Color(0xFFE8E8E8),
              highlightColor: Colors.white,
              child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(5), // radius of 10// green as background color
                  )),
            ),
            const LeaveListShimmer(),
          ],
        ),
      );
    } else if (state.status == NetworkStatus.success) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
         Text(
          "last_breaks",
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ).tr(),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              BreakTodayHistory? todayHistory = state
                  .breakReportModel?.data?.breakHistory?.todayHistory
                  ?.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      todayHistory?.breakTimeDuration ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 5,
                    color: globalState.get(breakStatus) == 'break_in'
                        ? const Color(0xFFE8356C)
                        : colorPrimary,
                  ),
                   SizedBox(
                    width: 35.0.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todayHistory?.reason ?? "",
                          style:  TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16.sp),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(todayHistory?.breakBackTime ?? "",style: TextStyle(fontSize: 12.sp),),
                      ],
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.breakReportModel?.data?.breakHistory?.todayHistory?.length ?? 0),
      ]);
    } else if (state.status == NetworkStatus.failure) {
      return Center(
        child: Text(
          "failed_to_load_break".tr(),
          style: TextStyle(
              color: colorPrimary.withOpacity(0.4),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
