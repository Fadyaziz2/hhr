import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            ? Visibility(
                visible: leaveBloc.state.filterLeaveSummaryResponse
                        ?.leaveSummaryData?.availableLeave?.isNotEmpty ??
                    false,
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: leaveBloc.state.filterLeaveSummaryResponse
                              ?.leaveSummaryData?.availableLeave?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final data = leaveBloc.state.filterLeaveSummaryResponse
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
                                                data?.leftDays?.toDouble() ?? 0,
                                            width: 0.1,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            color: Color(0xFF4358BE),
                                            cornerStyle: CornerStyle.bothCurve),
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                          widget: Text(
                                              data?.leftDays.toString() ?? "0",
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
              )
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
