import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/break_bloc.dart';
import 'content/break_content.dart';

class BreakScreen extends StatelessWidget {
  const BreakScreen({super.key});

  static Route route({required HomeBloc bloc}) {
    return MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: bloc, child: const BreakScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final homeBloc = context.read<HomeBloc>();
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (context) => BreakBloc(
        metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}',companyUrl: baseUrl),
      )..add(GetBreakHistoryData()),
      child: BreakContent(homeBloc: homeBloc),
    );
  }
}
