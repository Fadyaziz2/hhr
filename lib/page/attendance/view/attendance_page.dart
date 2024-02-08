import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/enum.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class AttendancePage extends StatelessWidget {
  final HomeBloc homeBloc;
  final AttendanceType attendanceType;

  const AttendancePage({super.key, required this.homeBloc, this.attendanceType = AttendanceType.normal});

  static Route route({required HomeBloc homeBloc,AttendanceType attendanceType = AttendanceType.normal}) {
    return MaterialPageRoute(builder: (_) => BlocProvider.value(value: homeBloc,child: AttendancePage(homeBloc: homeBloc,attendanceType: attendanceType,)));
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (BuildContext context) => AttendanceBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl),
          locationServices: locationServiceProvider,attendanceType: attendanceType)..add(OnLocationInitEvent(dashboardModel: homeBloc.state.dashboardModel)),
      child: const Scaffold(
        body: AttendanceView(),
      ),
    );
  }
}
