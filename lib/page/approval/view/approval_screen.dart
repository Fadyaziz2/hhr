import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/approval/view/content/approval_screen_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';

class ApprovalScreen extends StatelessWidget {

  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (_) => ApprovalBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))..add(ApprovalInitialDataRequest()),
        child: const ApprovalScreenContent());
  }
}
