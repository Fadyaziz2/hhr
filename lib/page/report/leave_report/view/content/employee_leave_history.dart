import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/leave_report/bloc/leave_report_bloc.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'leave_summary_details.dart';

class EmployeeLeaveHistory extends StatelessWidget {
  const EmployeeLeaveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(tr('employee_leave_history'))),
        body: BlocBuilder<LeaveReportBloc, LeaveReportState>(
            builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SelectEmployeePage(),
                            )).then((value) {
                          if (value != null) {
                            context
                                .read<LeaveReportBloc>()
                                .add(FilterLeaveReportSummary(value));
                          }
                        });
                      },
                      title: Text(state.selectedEmployeeName?.name ??
                          "Select Employee"),
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                      ),
                      trailing: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
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
                            state.filterLeaveSummaryResponse?.leaveSummaryData
                                    ?.totalLeave
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
                            state.filterLeaveSummaryResponse?.leaveSummaryData
                                    ?.totalUsed
                                    .toString() ??
                                '0',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Visibility(
                  // visible: provider.responseLeaveSummary?.data?.availableLeave?.isNotEmpty ?? false,
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.filterLeaveSummaryResponse
                                ?.leaveSummaryData?.availableLeave?.length ??
                            0,
                        // provider.responseLeaveSummary?.data?.availableLeave?.length??

                        itemBuilder: (context, index) {
                          final data = state.filterLeaveSummaryResponse
                              ?.leaveSummaryData?.availableLeave?[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 100,
                                        showLabels: false,
                                        showTicks: false,
                                        startAngle: 270,
                                        endAngle: 270,
                                        axisLineStyle: const AxisLineStyle(
                                          thickness: 0.1,
                                          color: Color(0xFFE8E8E9),
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                              value:
                                                  data?.leftDays?.toDouble() ??
                                                      0,
                                              width: 0.1,
                                              sizeUnit: GaugeSizeUnit.factor,
                                              color: Color(0xFF4358BE),
                                              cornerStyle:
                                                  CornerStyle.bothCurve),
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                            widget: Text(
                                                data?.leftDays.toString() ??
                                                    "0",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF414F5D))),
                                            positionFactor: 0,
                                            axisValue: 70,
                                          )
                                        ])
                                  ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(data?.type ?? "Sick",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                ///current date picker
                // currentDate(provider, context),
                // provider.isLoading == true ?
                // provider.leaveTypeList!.data!.availableLeave!.isNotEmpty
                //     ?

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filterLeaveSummaryResponse?.leaveSummaryData
                          ?.availableLeave?.length ??
                      0,
                  itemBuilder: (context, index) {
                    final data = state.filterLeaveSummaryResponse
                        ?.leaveSummaryData?.availableLeave?[index];
                    return Column(
                      children: [
                        Card(
                          child: InkWell(
                            onTap: () {
                              NavUtil.navigateScreen(
                                  context, const LeaveSummaryDetails());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              data?.type ?? "${tr('leave')}: ",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              data?.totalLeave.toString() ??
                                                  '${tr('days')}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "11/11/23",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 3.0,
                                      ),
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DottedBorder(
                                      color: Colors.white,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      strokeWidth: 1,
                                      child: const Center(
                                        child: Text(
                                          'pending',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    );
                  },
                )
              ]);
        }));
  }
}
