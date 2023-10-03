import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/bloc/attendance_bloc.dart';
import 'package:onesthrm/page/attendance_report/bloc/bloc.dart';
import 'package:onesthrm/page/attendance_report/view/content/content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';

class AttendanceReportPage extends StatelessWidget {
  final AttendanceBloc attendanceBloc;

  const AttendanceReportPage({Key? key, required this.attendanceBloc})
      : super(key: key);

  static Route route({required AttendanceBloc attendanceBloc}) {
    return MaterialPageRoute(
        builder: (_) => AttendanceReportPage(
              attendanceBloc: attendanceBloc,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return user != null ? BlocProvider(
      create: (context) => AttendanceReportBloc(
          user: user,
          metaClubApiClient: MetaClubApiClient(token: '${user.user?.token}'))
        ..add(GetAttendanceReportData()),
      child: BlocBuilder<AttendanceReportBloc, AttendanceReportState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Attendance Report'),
            ),
            body: ListView(
              children: [
                AttendanceReportContent(
                  bloc: context.watch<AttendanceReportBloc>(),
                ),
                const AttendanceDailyReportContent(),
              ],
            ),
          );
        },
      ),
    ) : const SizedBox.shrink();
  }
}
