import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/content/animated_circular_button.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/view/content/daily_leave_content.dart';
import 'package:onesthrm/page/daily_leave/view/daily_create_page.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/daily_leave_event.dart';
import 'content/daily_leave_status_widget.dart';

class DailyLeavePage extends StatelessWidget {
  const DailyLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => DailyLeaveBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}"))
        ..add(DailyLeaveSummary(user!.user!.id!)),
      child: const DailyLeaveContent(),
    );
  }
}
