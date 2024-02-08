import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class AttendancePage extends StatelessWidget {
  final HomeBloc homeBloc;
  final String? selfie;

  const AttendancePage({super.key, required this.homeBloc, this.selfie});

  static Route route({required HomeBloc homeBloc, String? selfie}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider.value(
            value: homeBloc,
            child: AttendancePage(
              homeBloc: homeBloc,
              selfie: selfie,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);
    print("selfie: $selfie");

    return BlocProvider(
      create: (BuildContext context) => AttendanceBloc(
          metaClubApiClient: MetaClubApiClient(
              token: '${user?.user?.token}', companyUrl: baseUrl),
          locationServices: locationServiceProvider,
          selfie: selfie)
        ..add(
            OnLocationInitEvent(dashboardModel: homeBloc.state.dashboardModel)),
      child: const Scaffold(
        body: AttendanceView(),
      ),
    );
  }
}
