import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'employee_leave_history.dart';

class LeaveSummeryScreen extends StatelessWidget {
  const LeaveSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('leave_summery')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListTile(
                        // onTap: () => NavUtil.navigateScreen(
                        //   context,
                        //    ReportLeaveListScreen(
                        //     title: tr('sick_leave'),
                        //   ),
                        // ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(tr('sick_leave')),
                        trailing: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '$index',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimary, shape: const StadiumBorder()),
            onPressed: () =>
                NavUtil.navigateScreen(context, const EmployeeLeaveHistory()),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16),
              child: Text(
                tr(
                  'search_all',
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
