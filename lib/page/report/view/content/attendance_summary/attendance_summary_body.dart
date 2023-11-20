import 'package:flutter/material.dart';
import 'package:onesthrm/page/attendance_report/view/content/summery_tile.dart';
import 'package:onesthrm/res/const.dart';

class AttendanceSummaryBody extends StatelessWidget {
  const AttendanceSummaryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SummeryTile(
                    titleValue: '01 days',
                    title: 'working_days',
                    color: colorPrimary),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'on_time',
                    color: Colors.green),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'late',
                    color: Colors.red),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'left_timely',
                    color: Colors.green),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'left_early',
                    color: Colors.red),
                SummeryTile(
                    titleValue: '12 days',
                    title: 'on_leave',
                    color: Colors.grey[400]!),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'absent',
                    color: Colors.black87),
                const SummeryTile(
                    titleValue: '12 days',
                    title: 'left_later',
                    color: Colors.amber),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: (){
              // print("You pressed Icon Elevated Button");
            },
            icon: const Icon(Icons.search,color: Colors.white,),  //icon data for elevated button
            label: const Text("Search All Employee Attendance",style: TextStyle(color: Colors.white),), //label text
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(400, 50),
                backgroundColor: Colors.blueAccent
            ),
          ),
        ],
      ),
    );
  }
}