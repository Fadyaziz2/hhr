import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/notice_list/view/notice_list_screen.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MetaClubApiClient _metaClubApiClient;

  MenuBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const MenuState(
          status: NetworkStatus.initial,
        )) {
    on<RouteSlug>(onRouteSlug);
  }

  void onRouteSlug(RouteSlug event, Emitter<MenuState> emit) {
    switch (event.slugName) {
      case 'support':
        break;
      // return NavUtil.navigateScreen(context, const SupportScreen());
      case 'attendance':
        break;
      // return NavUtil.navigateScreen(
      //     context,
      //     const Attendance(
      //       navigationMenu: true,
      //     ));
      case 'notice':
        NavUtil.navigateScreen(event.context, const NoticeListScreen());
        break;
      case 'expense':
        break;
      // return NavUtil.navigateScreen(context, const ExpenseList());
      case 'leave':
      // return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'approval':
      // return NavUtil.navigateScreen(context, const ApprovalScreen());
      case 'phonebook':
      // return NavUtil.navigateScreen(context, const PhonebookScreen());
      case 'conference':
      // return NavUtil.navigateScreen(context, const ConferenceScreen());
      case 'visit':
      // return NavUtil.navigateScreen(context, const VisitScreen());
      case 'meeting':
      // return NavUtil.navigateScreen(context, const MeetingScreen());
      case 'appointments':
      // return NavUtil.navigateScreen(context, const AppointmentScreen());
      // case 'face_attendance':
      //   return NavUtil.navigateScreen(
      //       context,
      //       const WebViewScreen(
      //           conferenceLink: "https://hrm.onesttech.com/faceattendance",appTitle: "Face Attendance",));
      case 'break':
      // return NavUtil.navigateScreen(
      //     context,
      //     NavUtil.navigateScreen(
      //         context,
      //         const BreakTime(
      //           diffTimeHome: '',
      //           hourHome: 0,
      //           minutesHome: 0,
      //           secondsHome: 0,
      //         )));
      case 'feedback':
      // return Fluttertoast.showToast(msg: 'feedback');
      case 'report':
      // return NavUtil.navigateScreen(context, const ReportScreen());
      case 'daily-leave':
      // return NavUtil.navigateScreen(context, const DailyLeave());
      case 'payroll':
      // return NavUtil.navigateScreen(context, const PayrollListScreen());
      case 'task':
      // return NavUtil.navigateScreen(context, const TaskDashboardScreen());
      default:
        return debugPrint('default');
    }
  }
}
