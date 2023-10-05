import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/bloc/appointment_create_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/view/appointment_create_screen.dart';
import 'package:onesthrm/page/appointment/get_employee/view/get_employee.dart';

class AppointmentWithCart extends StatelessWidget {
  final AppointmentCreateState? state;
  const AppointmentWithCart({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        buildTextTitle(tr("appointment_with")),
        Card(
          child: ListTile(
            onTap: () async {
              PhoneBookUser employee = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GetEmployeePage(),
                  ));
              // ignore: use_build_context_synchronously
              context
                  .read<AppointmentCreateBloc>()
                  // ignore: use_build_context_synchronously
                  .add(SelectEmployee(context, employee));
            },
            title:
                Text(state?.selectedEmployee?.name! ?? tr("add_a_Substitute")),
            subtitle: Text(state?.selectedEmployee?.designation! ??
                tr("add_a_Designation")),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(state?.selectedEmployee?.avatar ??
                  'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
            ),
            trailing: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
