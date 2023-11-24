import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/res/shimmers.dart';

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
                              width: 10.0,
                              height: 10.0,
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
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
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
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10.0,
                              height: 10.0,
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
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
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
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height: 65,
                      width: 150,
                    ),
                    Spacer(),
                    RectangularCardShimmer(
                      height: 65,
                      width: 150,
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
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    RectangularCardShimmer(
                      height: 55,
                      width: 100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RectangularCardShimmer(
                      height: 55,
                      width: 100,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
