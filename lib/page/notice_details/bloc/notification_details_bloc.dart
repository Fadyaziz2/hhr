import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'notification_details_event.dart';

part 'notification_details_state.dart';

class NotificationDetialsBloc
    extends Bloc<NotificationDetailsEvent, NotificationDetailsState> {
  final MetaClubApiClient _metaClubApiClient;

  NotificationDetialsBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const NotificationDetailsState(
          status: NetworkStatus.initial,
        )) {
    on<LoadNotificationDetailsData>(_onNotificationDataLoad);
  }

  void _onNotificationDataLoad(LoadNotificationDetailsData event,
      Emitter<NotificationDetailsState> emit) async {
    emit(const NotificationDetailsState(status: NetworkStatus.loading));
    try {
      ResponseNoticeDetails? notificationResponse =
          await _metaClubApiClient.getNotificationDetaisl(2);
      emit(state.copy(
          notificationResponse: notificationResponse,
          status: NetworkStatus.success));
    } catch (e) {
      emit(const NotificationDetailsState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
