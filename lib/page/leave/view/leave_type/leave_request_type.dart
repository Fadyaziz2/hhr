import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  elevation: 4,
                  child: RadioListTile<int?>(
                    value: 0,
                    title: Row(
                      children: [
                        const Text(
                          // provider
                          //     .leaveTypeList
                          //     ?.data
                          //     ?.availableLeave?[index]
                          //     .type ??
                          "Sick Leave",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          // '${provider.leaveTypeList?.data?.availableLeave?[index].leftDays} ${tr("days_left")}',
                          '19 ${tr("days_left")}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ).tr(),
                      ],
                    ),
                    groupValue: 0,
                    onChanged: (int? value) {
                      // provider.leaveTypeSelected(value!);
                    },
                  ),
                ),
              );
            }));
  }
}
