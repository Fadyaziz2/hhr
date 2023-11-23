import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/page/report/report.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'employee_leave_history.dart';

class LeaveReportSummaryContent extends StatelessWidget {
  const LeaveReportSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocBuilder<LeaveReportBloc, LeaveReportState>(
        builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Card(
              child: ListTile(
                leading: Text(state.leaveReportSummaryModel?.data?.date ?? ''),
                trailing: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: ListView.builder(
                itemCount:
                    state.leaveReportSummaryModel?.data?.leaveTypes?.length ??
                        0,
                itemBuilder: (BuildContext context, int index) {
                  final data =
                      state.leaveReportSummaryModel?.data?.leaveTypes?[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: ListTile(
                          // onTap: () => NavUtil.navigateScreen(
                          //   context,
                          //    ReportLeaveListScreen(
                          //     title: tr('sick_leave'),
                          //   ),
                          // ),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            tr(data?.name ?? ''),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          trailing: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              data?.count.toString() ?? '',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
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
            onPressed: () {
              NavUtil.navigateScreen(
                  context,
                  BlocProvider.value(
                      value: context.read<LeaveReportBloc>(),
                      child: const EmployeeLeaveHistory()));
            },
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
      );
    });
  }
}
