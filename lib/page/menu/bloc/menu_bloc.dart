import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/notice_list/view/notice_list_screen.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../phonebook/view/phonebook_page.dart';

part 'menu_event.dart';

part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MetaClubApiClient _metaClubApiClient;
  final Settings _settings;

  MenuBloc(
      {required MetaClubApiClient metaClubApiClient, required Settings setting})
      : _metaClubApiClient = metaClubApiClient,
        _settings = setting,
        super(const MenuState(
          status: NetworkStatus.initial,
        )) {
    on<RouteSlug>(onRouteSlug);
  }

  void onRouteSlug(RouteSlug event, Emitter<MenuState> emit) {
    switch (event.slugName) {
      case 'support':
        NavUtil.navigateScreen(event.context, const SupportPage());
        break;
      case 'attendance':
        break;
      case 'notice':
        NavUtil.navigateScreen(event.context, const NoticeListScreen());
        break;
      case 'expense':
        break;
      case 'leave':
      case 'approval':
      case 'phonebook':
        NavUtil.navigateScreen(event.context,  PhonebookPage(settings: _settings,));
        break;
      case 'conference':
      case 'visit':
      case 'meeting':
      case 'appointments':
      case 'break':
      case 'feedback':
      case 'report':
      case 'daily-leave':
      case 'payroll':
      case 'task':
       NavUtil.navigateScreen(event.context, const TaskScreen());
      break;
      default:
        return debugPrint('default');
    }
  }
}
