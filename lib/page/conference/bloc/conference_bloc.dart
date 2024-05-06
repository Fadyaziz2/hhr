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
    on<SelectStartTimeConference>(_showTime);
    on<SelectEndTimeConference>(_showEndTime);
    on<SelectedEmployeeEventConference>(_onSelectedEmployee);
  }

  FutureOr<void> _onSelectedEmployee(SelectedEmployeeEventConference event, Emitter<ConferenceState> emit) async {
    List<int> ids = [...state.selectedIds];
    List<String> users = [...state.selectedNames];
    for (var element in event.phoneBooks) {
      ids.add(element.id!);
      users.add(element.name!);
    }
    emit(state.copyWith(selectedIds: ids, selectedNames: users));
  }

  FutureOr<void> _showTime(
      SelectStartTimeConference event, Emitter<ConferenceState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      orientation: Orientation.portrait,
      initialTime: TimeOfDay.now(),
    );
    emit(state.copyWith(
      // ignore: use_build_context_synchronously
      startTime: result?.format(
        event.context,
      ),
    ));
  }

  FutureOr<void> _showEndTime(
      SelectEndTimeConference event, Emitter<ConferenceState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
      initialTime: TimeOfDay.now(),
    );
    emit(state.copyWith(
      // ignore: use_build_context_synchronously
      endTime: result?.format(
        event.context,
      ),
    ));
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
    String? currentMonthSchedule = getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(status: NetworkStatus.success, currentMonthSchedule: currentMonthSchedule));
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
