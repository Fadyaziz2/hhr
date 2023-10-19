import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'menu_drawer_state.dart';
part 'menu_drawer_event.dart';

class MenuDrawerBloc extends Bloc<MenuDrawerEvent, MenuDrawerState> {
  final MetaClubApiClient _metaClubApiClient;

  MenuDrawerBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const MenuDrawerState(
          status: NetworkStatus.initial,
        )) {
    on<MenuDrawerLoadData>(_onMenuDrawerData);
  }

  void _onMenuDrawerData(
      MenuDrawerLoadData event, Emitter<MenuDrawerState> emit) async {
    emit(const MenuDrawerState(
      status: NetworkStatus.loading,
    ));
    try {
      ResponseAllContents? responseAllContents =
          await _metaClubApiClient.getPolicyData(event.slug);
      emit(state.copyWith(
          status: NetworkStatus.success,
          responseAllContents: responseAllContents));
    } catch (e) {
      emit(const MenuDrawerState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  // void _onClearData(
  //     ClearNoticeButton event, Emitter<NoticeListState> emit) async {
  //   await _metaClubApiClient.clearAllNotificationApi();
  // }
}
