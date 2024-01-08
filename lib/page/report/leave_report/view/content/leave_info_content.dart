import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/device_util.dart';

class LeaveInfoContent extends StatelessWidget {
  const LeaveInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveBloc = context.watch<LeaveReportBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leaveBloc.state.filterLeaveSummaryResponse != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: DeviceUtil.isTablet ? 10.0.w : 10,
                              height: DeviceUtil.isTablet ? 10.0.h : 10,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tr('total_leaves'),
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 12.sp : 12 , color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          leaveBloc.state.filterLeaveSummaryResponse
                                  ?.leaveSummaryData?.totalLeave
                                  .toString() ??
                              '0',
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 25.sp :25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: DeviceUtil.isTablet ? 10.0.w : 10,
                              height: DeviceUtil.isTablet ? 10.0.h : 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4358BE),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              tr("leaves_used"),
                              style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 12.sp : 12, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          leaveBloc.state.filterLeaveSummaryResponse
                                  ?.leaveSummaryData?.totalUsed
                                  .toString() ??
                              '0',
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 25.sp : 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            :  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height: DeviceUtil.isTablet ? 65.h : 65,
                      width: DeviceUtil.isTablet ? 150.w : 150,
                    ),
                    const Spacer(),
                    RectangularCardShimmer(
                      height: DeviceUtil.isTablet ? 65.h : 65,
                      width: DeviceUtil.isTablet ? 150.w : 150,
                    ),
                  ],
                ),
              ),
        const SizedBox(
          height: 25,
        ),
        leaveBloc.state.filterLeaveSummaryResponse?.leaveSummaryData
                    ?.availableLeave?.isNotEmpty ==
                true
            ? const LeaveInfoListTile()
            :  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height: DeviceUtil.isTablet ? 55.sp : 55,
                      width: DeviceUtil.isTablet ? 100.sp : 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    RectangularCardShimmer(
                      height: DeviceUtil.isTablet ? 55.h : 55,
                      width: DeviceUtil.isTablet ? 100.w : 100,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
