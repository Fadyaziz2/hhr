import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/date_utils.dart';

part 'conference_event.dart';

part 'conference_state.dart';

class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  final MetaClubApiClient metaClubApiClient;

  ConferenceBloc({required this.metaClubApiClient})
      : super(const ConferenceState(status: NetworkStatus.loading)) {
    on<ConferenceInitialDataRequest>(_onConferenceInitialDataRequest);
    on<SelectDatePickerSchedule>(_onSelectDatePickerSchedule);
  }

  FutureOr<void> _onSelectDatePickerSchedule(
      SelectDatePickerSchedule event, Emitter<ConferenceState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonthSchedule =
    getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(
        status: NetworkStatus.success,
        currentMonthSchedule: currentMonthSchedule));
  }

  FutureOr<void> _onConferenceInitialDataRequest(
      ConferenceInitialDataRequest event, Emitter<ConferenceState> emit) async {
    try {
      final conference = await metaClubApiClient.getConferenceList();
      emit(state.copyWith(
          status: NetworkStatus.success, conference: conference));
    } on Exception catch (e) {
      emit(const ConferenceState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
