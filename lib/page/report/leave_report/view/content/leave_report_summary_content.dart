import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/page/report/report.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/device_util.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class LeaveReportSummaryContent extends StatelessWidget {
  const LeaveReportSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveReportBloc, LeaveReportState>(
        builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListTile(
                    leading: Text(state.leaveReportSummaryModel?.data?.date ?? '',style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<LeaveReportBloc>().add(SelectDatePicker(context));
                      },
                      icon: Icon(Icons.calendar_month,size: DeviceUtil.isTablet ? 24.sp : 24,),
                    )),
              ),
            ),
          ),
          state.leaveReportSummaryModel != null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: state.leaveReportSummaryModel?.data?.leaveTypes?.isNotEmpty ==true ? ListView.builder(
                      itemCount: state.leaveReportSummaryModel?.data?.leaveTypes?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final data = state.leaveReportSummaryModel?.data?.leaveTypes?[index];
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
                                onTap: () {
                                  NavUtil.navigateScreen(context,
                                    BlocProvider.value(
                                      value: context.read<LeaveReportBloc>(),
                                      child: LeaveTypeWiseSummary(leaveData: data!),
                                    ),
                                  );
                                },
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  tr(data?.name ?? ''),
                                  style: TextStyle(
                                    fontSize: DeviceUtil.isTablet ? 14.sp : 14,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    data?.count.toString() ?? '',
                                    style:  TextStyle(
                                        fontSize: DeviceUtil.isTablet ? 14.sp : 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ) : const Center(child: NoDataFoundWidget(title: "no_data_found",)),
                  ),
                )
              : Expanded(child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                     const TileShimmer();
                  },
                )),
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
              child: Text(tr('search_all'),
                style: TextStyle(color: Colors.white,fontSize: DeviceUtil.isTablet ? 16.sp : 16),
              ),
            ),
          ),
        ],
      );
    });
  }
}
