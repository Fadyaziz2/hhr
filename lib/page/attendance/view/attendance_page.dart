import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/page/internet_connectivity/bloc/internet_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class AttendancePage extends StatelessWidget {
  final HomeBloc homeBloc;
  final AttendanceType attendanceType;
  final String? selfie;

  const AttendancePage(
      {super.key,
      required this.homeBloc,
      this.attendanceType = AttendanceType.normal,
      this.selfie});

  static Route route(
      {required HomeBloc homeBloc,
      AttendanceType attendanceType = AttendanceType.normal,
      String? selfie}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: homeBloc,
        child: AttendancePage(
          homeBloc: homeBloc,
          attendanceType: attendanceType,
          selfie: selfie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (_) => AttendanceBloc(
          metaClubApiClient: MetaClubApiClient(httpServiceImpl: instance()),
          locationServices: locationServiceProvider,
          attendanceType: attendanceType,
          selfie: selfie,
          attendanceService: attendanceService,
          internetStatus: context.watch<InternetBloc>().state.status)
          ..add(OnLocationInitEvent(dashboardModel: homeBloc.state.dashboardModel)),
      child: Scaffold(
        body: AttendanceView(attendanceType: attendanceType),
      ),
    );
  }
}
