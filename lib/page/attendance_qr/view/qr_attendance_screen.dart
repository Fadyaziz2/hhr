import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance_qr/bloc/qr_attendance_bloc.dart';
import 'package:onesthrm/page/attendance_qr/view/content/qr_attendance_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/res/const.dart';

class QRAttendanceScreen extends StatelessWidget {
  const QRAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (_) => QRAttendanceBloc(
          metaClubApiClient: MetaClubApiClient(
              token: '${user?.user?.token}', companyUrl: baseUrl)),
      child: const Scaffold(
          backgroundColor: Colors.black, body: QRAttendanceContent()),
    );
  }
}
