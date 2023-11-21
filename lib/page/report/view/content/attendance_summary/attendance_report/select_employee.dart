import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/report.dart';

import '../../../../../select_employee/view/select_employee.dart';

class SelectEmployeeForAttendance extends StatelessWidget {
  const SelectEmployeeForAttendance({
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
              context.read<ReportBloc>().add(SelectEmployee(value));
            }
          });
        },
        title: Text(
            context.watch<ReportBloc>().state.selectEmployee?.name! ??
                'Select Employee'),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(context
              .watch<ReportBloc>()
              .state
              .selectEmployee
              ?.avatar ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
        ),
      ),
    );
  }
}