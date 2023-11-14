import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/select_employee/view/select_employee.dart';

class ApplyDailySelectEmployee extends StatelessWidget {
  const ApplyDailySelectEmployee({
    super.key,
    required this.bloc,
  });

  final DailyLeaveBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          PhoneBookUser? employee = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectEmployeePage(),
              ));
          if(employee != null){
            bloc.add(SelectEmployee(employee));
          }
        },
        title: Text(bloc.state.selectEmployee?.name! ?? 'Select Employee'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(bloc.state.selectEmployee?.avatar ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
        ),
      ),
    );
  }
}
