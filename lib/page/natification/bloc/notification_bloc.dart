import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final MetaClubApiClient _metaClubApiClient;

  NotificationBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const NotificationState(
          status: NetworkStatus.initial,
        )) {
    on<LoadNotificationData>(_onNotificationDataLoad);
  }

  void _onNotificationDataLoad(
      LoadNotificationData event, Emitter<NotificationState> emit) async {
    emit(const NotificationState(status: NetworkStatus.loading));
    try {
      NotificationResponse? notificationResponse =
          await _metaClubApiClient.getNotification();
      emit(state.copy(
          notificationResponse: notificationResponse,
          status: NetworkStatus.success));
    } catch (e) {
      emit(const NotificationState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
