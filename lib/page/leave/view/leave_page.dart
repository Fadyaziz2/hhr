import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/res/const.dart';

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          AnimatedCircularButton(
            onComplete: () {
              // context
              //     .read<AttendanceBloc>()
              //     .add(OnAttendance(homeData: homeData!));
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
                        const Text(
                          "total_leaves",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ).tr()
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("20",
                      style: TextStyle(
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
                            color: colorPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "leaves_used",
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ).tr()
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("10",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
