import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

part 'attendance_method_event.dart';
part 'attendance_method_state.dart';

class AttendanceMethodBloc
    extends Bloc<AttendanceMethodEvent, AttendanceMethodState> {
  final HomeBloc _homeBloc;

  AttendanceMethodBloc(
      {required MetaClubApiClient metaClubApiClient,
      required HomeBloc homeBloc})
      : _homeBloc = homeBloc,
        super(const AttendanceMethodState(
          status: NetworkStatus.initial,
        )) {
    on<AttendanceNavEvent>(onRouteSlug);
  }

  void onRouteSlug(
    AttendanceNavEvent event,
    Emitter<AttendanceMethodState> emit,
  ) {
    switch (event.slugName) {
      case 'normal_attendance':
        Navigator.push(event.context, AttendancePage.route(homeBloc: _homeBloc));
        break;
      case 'face_attendance':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      case 'qr_attendance':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      case 'selfie_attendance':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      default:
        return debugPrint('default');
    }
  }
}
