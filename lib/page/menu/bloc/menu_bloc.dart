import 'dart:async';
import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/attendance_method/view/attendane_method_screen.dart';
import 'package:onesthrm/page/break/view/break_page.dart';
import 'package:onesthrm/page/conference/conference.dart';
import 'package:onesthrm/page/daily_leave/view/daily_leave_page.dart';
import 'package:onesthrm/page/expense/view/expense_page.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/leave/view/leave_page.dart';
import 'package:onesthrm/page/meeting/meeting.dart';
import 'package:onesthrm/page/notice_list/view/notice_list_screen.dart';
import 'package:onesthrm/page/payroll/view/view.dart';
import 'package:onesthrm/page/report/report_page.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/page/visit/view/visit_page.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:user_repository/user_repository.dart';
import '../../phonebook/view/phonebook_page.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final Settings _settings;
  final LoginData _loginData;
  final Color _primaryColor;
  final GetAppNameUseCase _getAppName;
  final GetAppVersionUseCase _getAppVersion;

  MenuBloc({required MetaClubApiClient metaClubApiClient,
      required LoginData loginData,
      required Color color,
      required GetAppNameUseCase getAppName,
      required GetAppVersionUseCase getAppVersion,
      required Settings setting})
      : _settings = setting,
        _loginData = loginData,
        _getAppName = getAppName,
        _getAppVersion = getAppVersion,
        _primaryColor = color,
        super(const MenuState(
          status: NetworkStatus.initial,
        )) {
    on<RouteSlug>(onRouteSlug);
    on<OnAppServiceEvent>(_onAppService);
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
        Navigator.push(event.context, AttendanceMethodScreen.route(homeBloc: event.context.read<HomeBloc>()));
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
      case 'chat':
        NavUtil.navigateScreen(
            event.context,
            ChatRoom(
              uid: '${_loginData.user?.id ?? 0}',
              primaryColor: _primaryColor,
            ));
        break;
      case 'phonebook':
        NavUtil.navigateScreen(
            event.context,
            PhoneBookPage(
              settings: _settings,
            ));
        break;
      case 'conference':
        NavUtil.navigateScreen(event.context, const ConferencePage());
        break;
      case 'visit':
        NavUtil.navigateScreen(event.context, const VisitPage());
        break;
      case 'meeting':
        NavUtil.navigateScreen(event.context, const MeetingPage());
        break;
      case 'appointments':
        NavUtil.navigateScreen(event.context, const AppointmentScreen());
        break;
      case 'break':
        NavUtil.navigateScreen(
            event.context, BlocProvider.value(value: event.context.read<HomeBloc>(), child: const BreakScreen()));
        break;
      case 'feedback':
      case 'report':
        NavUtil.navigateScreen(event.context, const ReportPage());
        break;
      case 'daily_leave':
        NavUtil.navigateScreen(event.context, const DailyLeavePage());
        break;
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

  FutureOr<void> _onAppService(OnAppServiceEvent event, Emitter<MenuState> emit) async {
    final appVersion = await _getAppVersion();
    final appName = await _getAppName();
    emit(state.copy(appVersion: appVersion,appName: appName));
  }
}
