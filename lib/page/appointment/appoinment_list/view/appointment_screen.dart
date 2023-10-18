import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appoinment_list/bloc/appointment_bloc.dart';
import 'package:onesthrm/page/appointment/appointment_create/view/appointment_create_screen.dart';
import 'package:onesthrm/page/appointment/appoinment_list/content/appointment_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/res/nav_utail.dart';

AppointmentBloc? bloc;

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => AppointmentBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(GetAppointmentData()),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                NavUtil.navigateScreen(
                    context,
                    AppointmentCreateScreen(
                      appointmentBloc: bloc,
                    ));
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(tr("appointments")),
              actions: [
                IconButton(
                    onPressed: () {
                      context
                          .read<AppointmentBloc>()
                          .add(SelectDatePicker(context));
                    },
                    icon: const Icon(Icons.calendar_month_outlined))
              ],
            ),
            body: const AppointmentContent(),
          );
        },
      ),
    );
  }
}
