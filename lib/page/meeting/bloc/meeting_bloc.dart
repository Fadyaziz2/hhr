import 'dart:async';
import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/date_utils.dart';
import '../../../res/enum.dart';
import '../../../res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'meeting_event.dart';

part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MetaClubApiClient _metaClubApiClient;

  MeetingBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const MeetingState()) {
    on<MeetingListEvent>(_onMeetingList);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<SelectStartTime>(_showTime);
    on<SelectEndTime>(_showEndTime);
    on<SelectDatePickerSchedule>(_onSelectDatePickerSchedule);
    on<CreateMeetingEvent>(_onCreateMeetingEvent);
  }

  FutureOr<void> _showTime(
      SelectStartTime event, Emitter<MeetingState> emit) async {
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

  FutureOr<void> _onSelectDatePickerSchedule(
      SelectDatePickerSchedule event, Emitter<MeetingState> emit) async {
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

  FutureOr<void> _showEndTime(
      SelectEndTime event, Emitter<MeetingState> emit) async {
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

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<MeetingState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 1),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(MeetingListEvent(date: currentMonth));
  }

  FutureOr<void> _onMeetingList(
      MeetingListEvent event, Emitter<MeetingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final meetingListResponse = await _metaClubApiClient
          .getMeetingList(state.currentMonth ?? event.date);
      emit(state.copyWith(
          status: NetworkStatus.success,
          meetingsListResponse: meetingListResponse));
    } on Exception catch (e) {
      emit(const MeetingState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onCreateMeetingEvent(
      CreateMeetingEvent event, Emitter<MeetingState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      await _metaClubApiClient
          .createMeetingApi(meetingBodyModel: event.bodyCreateMeeting)
          .then((success) {
        if (success) {
          Fluttertoast.showToast(msg: "Meeting Create Successfully");
          emit(state.copyWith(status: NetworkStatus.success));
          add(MeetingListEvent(date: event.date));
          Navigator.pop(event.context);
        } else {
          Fluttertoast.showToast(msg: "Something went wrong!");
          emit(state.copyWith(status: NetworkStatus.failure));
        }
      });
    } on Exception catch (e) {
      emit(const MeetingState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
