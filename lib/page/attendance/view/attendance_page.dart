import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/home.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class AttendancePage extends StatelessWidget {
  final HomeBloc homeBloc;

  const AttendancePage({Key? key, required this.homeBloc}) : super(key: key);

  static Route route({required HomeBloc homeBloc}) {
    return MaterialPageRoute(builder: (_) => AttendancePage(homeBloc: homeBloc,));
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (BuildContext context) => AttendanceBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'),
          locationServices: locationServiceProvider)..add(OnLocationInitEvent()),
      child: Scaffold(
        body: AttendanceView(homeBloc: homeBloc),
      ),
    );
  }
}
