import 'dart:async';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final MetaClubApiClient _metaClubApiClient;

  AppointmentBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const AppointmentState(status: NetworkStatus.initial)) {
    on<GetAppointmentData>(_onAppointmentLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onAppointmentLoad(
      GetAppointmentData event, Emitter<AppointmentState> emit) async {
    final currentDate = getDateAsString(format: 'y-MM', dateTime: DateTime.now());
    emit(AppointmentState(
        status: NetworkStatus.loading, currentMonth: event.date));
    try {
      final MeetingsListModel? success = await _metaClubApiClient
          .getMeetingsItem(state.currentMonth ?? currentDate);
      if (success != null) {
        emit(AppointmentState(
            status: NetworkStatus.success,
            meetingsListData: success,
            currentMonth: event.date));
      } else {
        emit(AppointmentState(
            status: NetworkStatus.failure, currentMonth: event.date));
      }
    } catch (e) {
      emit(AppointmentState(
          status: NetworkStatus.failure, currentMonth: event.date));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<AppointmentState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 1),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(GetAppointmentData(date: currentMonth));
  }
}
