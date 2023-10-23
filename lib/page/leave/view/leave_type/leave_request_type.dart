import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/leave/view/leave_calender/leave_calender.dart';
import 'package:onesthrm/res/nav_utail.dart';

class LeaveRequestType extends StatelessWidget {
  const LeaveRequestType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Leave Request Type"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  NavUtil.navigateScreen(context, const LeaveCalender());
                },
                child: Card(
                  elevation: 4,
                  child: RadioListTile<int?>(
                    value: 0,
                    title: Row(
                      children: [
                        const Text(
                          "Sick Leave",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          '19 ${tr("days_left")}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ).tr(),
                      ],
                    ),
                    groupValue: 0,
                    onChanged: (int? value) {},
                  ),
                ),
              );
            }));
  }
}
