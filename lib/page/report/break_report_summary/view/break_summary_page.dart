import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/report/break_report_summary/break_report.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../../authentication/bloc/authentication_bloc.dart';

class BreakReportSummary extends StatelessWidget {
  const BreakReportSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (BuildContext context) => BreakBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'),
          userId: user!.user!.id!)
        ..add(GetBreakInitialData()),
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF00CCFF),
                      colorPrimary,
                    ],
                    begin: FractionalOffset(3.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            title: Text(
              tr('break_summary'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor),
            ),
          ),
          body: const BreakSummaryContent()),
    );
  }
}
