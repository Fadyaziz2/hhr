import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'leave_summary_details.dart';

class EmployeeLeaveHistory extends StatelessWidget {
  const EmployeeLeaveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(tr('employee_leave_history'))),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 16,
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "20",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "10",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                  itemCount:
                      // provider.responseLeaveSummary?.data?.availableLeave?.length??
                      2,
                  itemBuilder: (context, index) {
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
                                  pointers: const <GaugePointer>[
                                    RangePointer(
                                        value: 10,
                                        width: 0.1,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        color: Color(0xFF4358BE),
                                        cornerStyle: CornerStyle.bothCurve),
                                  ],
                                  annotations: const <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Text("10",
                                          style: TextStyle(
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
                          const Text("Sick",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
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

          Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    "Sick${tr('leave')}: ",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '10 ${tr('days')}',
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
          )
        ]));
  }
}
