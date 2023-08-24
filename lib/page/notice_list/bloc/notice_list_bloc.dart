import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

part 'notice_list_event.dart';

part 'notice_list_state.dart';

class NotificationListBloc extends Bloc<NoticeListEvent, NoticeListState> {
  final MetaClubApiClient _metaClubApiClient;

  NotificationListBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const NoticeListState(
          status: NetworkStatus.initial,
        )) {
    on<LoadNotificationListData>(_onNoticeListDataLoad);
  }

  void _onNoticeListDataLoad(
      LoadNotificationListData event, Emitter<NoticeListState> emit) async {
    emit(const NoticeListState(status: NetworkStatus.loading));
    try {
      NoticeListModel? noticeListModel =
          await _metaClubApiClient.getNoticeList();
      emit(state.copy(
          noticeListModel: noticeListModel, status: NetworkStatus.success));
    } catch (e) {
      emit(const NoticeListState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
