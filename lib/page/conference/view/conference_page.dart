import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/conference/conference.dart';
import 'package:onesthrm/res/const.dart';

class ConferencePage extends StatelessWidget {
  const ConferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
        create: (_) => ConferenceBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl))..add(ConferenceInitialDataRequest()),
        child: const ConferenceContentScreen());
  }
}
