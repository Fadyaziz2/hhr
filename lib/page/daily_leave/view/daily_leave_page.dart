import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/res/const.dart';

class DailyLeavePage extends StatelessWidget {
  const DailyLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("daily_leave")),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          AnimatedCircularButton(
            onComplete: () {
              // NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<LeaveBloc>(),child: const LeaveRequestType()));
            },
            title: "Apply Daily Leave",
            color: colorPrimary,
          ),
          const Center(
              child: Text(
            "Approved Leave",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )),

        ],
      ),
    );
  }
}
