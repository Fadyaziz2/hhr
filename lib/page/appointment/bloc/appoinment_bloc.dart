import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'appoinment_event.dart';
part 'appoinment_state.dart';

class AppoinmentBloc extends Bloc<AppoinmentEvent, AppoinmentState> {
  final MetaClubApiClient _metaClubApiClient;

  AppoinmentBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const AppoinmentState(status: NetworkStatus.initial)) {
    on<GetAppoinmentData>(_onAppoinmentLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onAppoinmentLoad(
      GetAppoinmentData event, Emitter<AppoinmentState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    emit(AppoinmentState(
        status: NetworkStatus.loading, currentMonth: event.date));
    try {
      final MeetingsListModel? success = await _metaClubApiClient
          .getMeetingsItem(state.currentMonth ?? currentDate);
      if (success != null) {
        emit(AppoinmentState(
            status: NetworkStatus.success,
            meetingsListData: success,
            currentMonth: event.date));
      } else {
        emit(AppoinmentState(
            status: NetworkStatus.failure, currentMonth: event.date));
      }
    } catch (e) {
      emit(AppoinmentState(
          status: NetworkStatus.failure, currentMonth: event.date));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<AppoinmentState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date!);
    add(GetAppoinmentData(date: currentMonth));
  }
}
