import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/leave/view/leave_calendar/leave_calendar.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../../../res/widgets/custom_button.dart';

class LeaveRequestType extends StatelessWidget {
  const LeaveRequestType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Leave Request Type"),
        ),
        body: Column(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(12),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
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
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 5,
              ),
            ),
             CustomButton(
              title: "Next",
              padding: 16,
               clickButton: (){
                NavUtil.navigateScreen(context, const LeaveCalendar());
               },

            )
          ],
        ));
  }
}
