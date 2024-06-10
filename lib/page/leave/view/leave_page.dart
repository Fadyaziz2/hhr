import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/view/content/leave_summary_content.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    // final baseUrl = globalState.get(companyUrl);
    return BlocProvider(
        create: (context) => LeaveBloc(metaClubApiClient: MetaClubApiClient(httpService: instance()))
          ..add(LeaveSummaryApi(user!.user!.id!))
          ..add(LeaveRequest(user.user!.id!))
          ..add(LeaveRequestTypeEvent(user.user!.id!)),
        child: const LeaveSummaryContent());
  }
}
