import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/expense/view/expense_page.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/leave/view/leave_page.dart';
import 'package:onesthrm/page/notice_list/view/notice_list_screen.dart';
import 'package:onesthrm/page/payroll/view/view.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../break/view/break_page.dart';
import '../../phonebook/view/phonebook_page.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MetaClubApiClient _metaClubApiClient;
  final Settings _settings;
  final HomeBloc _bloc;

  MenuBloc(
      {required MetaClubApiClient metaClubApiClient, required Settings setting,required HomeBloc bloc})
      : _metaClubApiClient = metaClubApiClient,
        _settings = setting,
        _bloc = bloc,
        super(const MenuState(
          status: NetworkStatus.initial,
        )) {
    on<RouteSlug>(onRouteSlug);
  }

  void onRouteSlug(
    RouteSlug event,
    Emitter<MenuState> emit,
  ) {

    switch (event.slugName) {
      case 'support':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      case 'attendance':
        NavUtil.navigateScreen(
            event.context,
            AttendancePage(
              homeBloc: event.context.read<HomeBloc>(),
            ));
        break;
      case 'notice':
        NavUtil.navigateScreen(event.context, const NoticeListScreen());
        break;
      case 'expense':
        NavUtil.navigateScreen(event.context, const ExpensePage());
        break;
      case 'leave':
        NavUtil.navigateScreen(event.context, const LeavePage());
        break;
      case 'approval':
        NavUtil.navigateScreen(event.context, const ApprovalScreen());
        break;
      case 'phonebook':
        NavUtil.navigateScreen(
            event.context,
            PhoneBookPage(
              settings: _settings,
            ));
        break;
      case 'conference':
      case 'visit':
      case 'meeting':
      case 'appointments':
        NavUtil.navigateScreen(event.context, const AppointmentScreen());
        break;
      case 'break':
        NavUtil.navigateScreen(event.context,  BlocProvider.value(value: _bloc,child: const BreakScreen()));
        break;
      case 'feedback':
      case 'report':
      case 'daily-leave':
      case 'payroll':
        NavUtil.navigateScreen(event.context, const PayrollScreen());
        break;
      case 'task':
        NavUtil.navigateScreen(event.context, const TaskScreen());
        break;
      default:
        return debugPrint('default');
    }
  }
}
