import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/break_bloc.dart';
import '../content/break_content.dart';

class BreakScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final DashboardModel? dashboardModel;

  const BreakScreen(
      {super.key, required this.homeBloc, required this.dashboardModel});

  static Route route(
      {required HomeBloc homeBloc, required DashboardModel? dashboardModel}) {
    return MaterialPageRoute(
        builder: (_) =>
            BreakScreen(homeBloc: homeBloc, dashboardModel: dashboardModel));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => BreakBloc(
        metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'),
      )..add(GetBreakHistoryData()),
      child: BreakContent(homeBloc: homeBloc),
    );
  }
}
