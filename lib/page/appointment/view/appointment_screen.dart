import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/bloc/appoinment_bloc.dart';
import 'package:onesthrm/page/appointment/content/appoinment_content.dart';
import 'package:onesthrm/page/appointment_create/view/appointment_create_screen.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/res/nav_utail.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return RefreshIndicator(
      onRefresh: () async {
        // provider.getAppointmentList();
      },
      child: BlocProvider(
        create: (context) => AppoinmentBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(GetAppoinmentData()),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            // backgroundColor: AppColors.colorPrimary,
            onPressed: () {
              NavUtil.replaceScreen(context, const AppointmentCreateScreen());
            },

            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(tr("appointment_list")),
          ),
          body: const AppointmentContent(),
        ),
      ),
    );
  }
}
