import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../authentication/bloc/authentication_bloc.dart';
import '../../../report.dart';

class AttendanceSummaryContent extends StatelessWidget {
  const AttendanceSummaryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (BuildContext context) => ReportBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(GetReportData()),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Attendance Summary'),
            ),
            body: const AttendanceSummaryBody()));
  }
}
