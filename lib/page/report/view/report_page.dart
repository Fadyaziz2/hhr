import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/report/report.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (BuildContext context) => ReportBloc(
            metaClubApiClient:
                MetaClubApiClient(token: '${user?.user?.token}')),
        child: Scaffold(
          appBar: AppBar(title: const Text('Report Summary'),),
            body: const ReportContent()));
  }
}
