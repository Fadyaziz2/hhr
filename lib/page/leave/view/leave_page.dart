import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_event.dart';
import 'package:onesthrm/page/leave/bloc/leave_state.dart';
import 'package:onesthrm/page/leave/view/content/leave_summary_content.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({Key? key}) : super(key: key);

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
    return BlocProvider(
      create: (context) => LeaveBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}"))
        ..add(LeaveSummaryApi(context))
        ..add(LeaveRequest(context)),
      child: BlocBuilder<LeaveBloc, LeaveState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Leave Summary"),
              actions: [
                IconButton(
                    onPressed: () {
                      // context.read<SupportBloc>().add(SelectDatePicker(context));
                    },
                    icon: const Icon(Icons.calendar_month_outlined))
              ],
            ),
            body: LeaveSummaryContent(
              state: state,
            ),
          );
        },
      ),
    );
  }
}
