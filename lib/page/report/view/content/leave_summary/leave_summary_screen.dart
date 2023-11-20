import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/report/bloc/report_bloc.dart';
import 'leave_report_summary_content.dart';

class LeaveSummeryScreen extends StatelessWidget {
  const LeaveSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (BuildContext context) => ReportBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(GetLeaveReportSummary()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr('leave_summery')),
        ),
        body: const LeaveReportSummaryContent(),
      ),
    );
  }
}
