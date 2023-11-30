import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/enum.dart';

part 'meeting_event.dart';

part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MetaClubApiClient _metaClubApiClient;

  MeetingBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const MeetingState()) {
    on<MeetingListEvent>(_onMeetingList);
    // on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onMeetingList(
      MeetingListEvent event, Emitter<MeetingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final meetingListResponse = await _metaClubApiClient.getMeetingList();
      emit(state.copyWith(
          status: NetworkStatus.success,
          meetingsListResponse: meetingListResponse));
    } on Exception catch (e) {
      emit(const MeetingState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
