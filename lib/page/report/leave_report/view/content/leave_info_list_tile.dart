import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LeaveInfoListTile extends StatelessWidget {
  const LeaveInfoListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveAvailable = context
        .watch<LeaveReportBloc>()
        .state
        .filterLeaveSummaryResponse
        ?.leaveSummaryData
        ?.availableLeave;
    return Visibility(
      visible: leaveAvailable?.isNotEmpty ?? false,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: leaveAvailable?.length ?? 0,
            itemBuilder: (context, index) {
              final data = leaveAvailable?[index];
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
                                  value: data?.leftDays?.toDouble() ?? 0,
                                  width: 0.1,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFF4358BE),
                                  cornerStyle: CornerStyle.bothCurve),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Text(data?.leftDays.toString() ?? "0",
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
