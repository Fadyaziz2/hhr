import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/meeting/bloc/meeting_bloc.dart';
import 'package:core/core.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'content/meeting_content.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (_) => MeetingBloc(metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}", companyUrl: baseUrl))..add(MeetingListEvent()),
      child: const MeetingContent(),
    );
  }
}
