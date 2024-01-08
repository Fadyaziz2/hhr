import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/report/leave_report/bloc/leave_report_bloc.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';
import 'package:onesthrm/res/widgets/device_util.dart';

import '../view.dart';

class EmployeeLeaveHistory extends StatelessWidget {
  const EmployeeLeaveHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    context.read<LeaveReportBloc>().add(LeaveRequest());
    return BlocBuilder<LeaveReportBloc, LeaveReportState>(
        builder: (context, state) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80 : 55),
            child: AppBar(
              iconTheme: IconThemeData(size: DeviceUtil.isTablet ? 40 : 30,   color: Colors.white),
              title: Text(tr('employee_leave_history'),style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context
                        .read<LeaveReportBloc>()
                        .add(SelectMonthPicker(context));
                  },
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectEmployeePage(),
                          )).then((value) {
                        if (value != null) {
                          context.read<LeaveReportBloc>().add(SelectLeaveEmployee(value));
                        }
                      });
                    },
                    title: Text(context.watch<LeaveReportBloc>().state.selectedEmployee?.name ??
                        user!.user!.name!,style: TextStyle(fontSize: DeviceUtil.isTablet ? 16.sp : 16),),
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                    ),
                    trailing: Icon(Icons.search,size: DeviceUtil.isTablet ? 24.sp : 24,),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const LeaveInfoContent(),
              const SizedBox(
                height: 12,
              ),
              const LeaveReportList()
            ]),
          ));
    });
  }
}
