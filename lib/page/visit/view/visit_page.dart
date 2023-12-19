import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/visit/bloc/visit_bloc.dart';
import 'package:onesthrm/page/visit/view/content/visit_content.dart';
import 'package:onesthrm/res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class VisitPage extends StatelessWidget {
  const VisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
      create: (_) => VisitBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}", companyUrl: baseUrl))
        ..add(VisitListEvent())
        ..add(HistoryListEvent()),
      child: const VisitContent(),
    );
  }
}
