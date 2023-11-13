import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';

class ApplyDailySelectEmployee extends StatelessWidget {
  const ApplyDailySelectEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    return Card(
      child: ListTile(
        onTap: () async {
          PhoneBookUser employee = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectEmployeePage(),
              ));
          dailyLeaveBloc.add(SelectEmployee(employee));
        },
        title: Text(dailyLeaveBloc.state.selectEmployee?.name! ?? 'Select Employee'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(dailyLeaveBloc.state.selectEmployee?.avatar ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
        ),
      ),
    );
  }
}
