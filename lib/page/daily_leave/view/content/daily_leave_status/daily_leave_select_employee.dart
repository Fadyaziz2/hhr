import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';

class ApplyDailySelectEmployee extends StatelessWidget {
  const ApplyDailySelectEmployee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectEmployeePage(),
              )).then((value) {
            if (value != null) {
              context.read<DailyLeaveBloc>().add(SelectEmployee(value));
            }
          });
        },
        title: Text(
            context.watch<DailyLeaveBloc>().state.selectEmployee?.name! ??
                'select_employee'.tr()),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(context
                  .watch<DailyLeaveBloc>()
                  .state
                  .selectEmployee
                  ?.avatar ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
        ),
      ),
    );
  }
}
