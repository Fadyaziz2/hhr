import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/page/daily_leave/view/daily_create_page.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'content/leave_status.dart';

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
            NavUtil.navigateScreen(context, const DailyCreatePage());
            },
            title: "Apply Daily Leave",
            color: colorPrimary,
          ),
          const Center(
              child: Text(
            "Approved Leave",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          )),
          const SizedBox(
            height: 30,
          ),
          const DailyLeaveStatusWidget(
            color: Colors.green,
            title: "Early Leave",
            count: "0",
          ),
          const SizedBox(height: 30,),
          const DailyLeaveStatusWidget(
            color: Colors.green,
            title: "Late Arrive",
            count: "0",
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 0.5,color: Colors.black12,),
          const SizedBox(height: 10,),
          const Center(
              child: Text(
                "Rejected Leave",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              )),
          const SizedBox(
            height: 20,
          ),
          const DailyLeaveStatusWidget(
            color: Colors.red,
            title: "Early Leave",
            count: "0",
          ),
          const SizedBox(height: 30,),
          const DailyLeaveStatusWidget(
            color: Colors.red,
            title: "Lave Arrive",
            count: "0",
          ),
          const SizedBox(height: 10,),
          const Divider(thickness: 0.5,color: Colors.black12,),
          const SizedBox(height: 10,),
          const Center(
              child: Text(
                "Padding Leave",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              )),
          const SizedBox(
            height: 30,
          ),
           DailyLeaveStatusWidget(
            color: Colors.yellow.shade500,
            title: "Early Leave",
            count: "0",
          ),
          const SizedBox(height: 30,),
           DailyLeaveStatusWidget(
            color: Colors.yellow.shade500,
            title: "Late Arrive",
            count: "0",
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
