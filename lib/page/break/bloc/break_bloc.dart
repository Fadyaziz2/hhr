import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/const.dart';
import '../../app/global_state.dart';

part 'break_event.dart';

part 'break_state.dart';

class BreakBloc extends Bloc<BreakEvent, BreakState> {
  final MetaClubApiClient _metaClubApiClient;

  BreakBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const BreakState()) {
    on<OnCustomTimerStart>(_onCustomTimerStart);
    on<OnBreakBackEvent>(_onBreakBack);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<GetBreakHistoryData>(_onBreakHistoryDataLoad);
    on<OnInitialHistoryEvent>(_onInitialBreakHistory);
  }

  FutureOr<void> _onCustomTimerStart(
      OnCustomTimerStart event, Emitter<BreakState> emit) {
    emit(state.copyWith(isTimerStart: !state.isTimerStart));
  }

  FutureOr<void> _onBreakBack(
      OnBreakBackEvent event, Emitter<BreakState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    Break? data = await _metaClubApiClient.backBreak();

    final todayHistories = data?.data?.breakBackHistory?.todayHistory;

    String breakBack =
        '${data?.data?.breakTime} - ${data?.data?.backTime ?? ''}';

    if (data?.data?.status != 'break_in') {
      if (todayHistories?.isNotEmpty == true) {
        state.breakReportModel?.data?.breakHistory?.todayHistory!.insert(
            0,
            BreakTodayHistory(
                name: 'Break',
                reason: 'Break',
                breakBackTime: todayHistories![0].breakBackTime ?? breakBack,
                breakTimeDuration:
                    todayHistories[0].breakTimeDuration ?? '0 min'));
      } else {
        if (data?.result == true) {
          state.breakReportModel?.data?.breakHistory?.todayHistory!.insert(0, BreakTodayHistory(name: 'Break', reason: 'Break', breakBackTime: breakBack, breakTimeDuration: '0 min'));
        }
      }
    }

    globalState.set(breakTime, data?.data?.breakTime);
    globalState.set(backTime, data?.data?.backTime);
    globalState.set(breakStatus, data?.data?.status);
    globalState.set(hour, '0');
    globalState.set(min, '0');
    globalState.set(sec, '0');

    add(OnCustomTimerStart(hour: 0, min: 0, sec: 0));
    emit(state.copyWith(status: NetworkStatus.success, breakBack: data));
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<BreakState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentDate = getDateAsString(format: 'yyyy-MM-dd', dateTime: date);
    add(GetBreakHistoryData(date: currentDate));
  }

  FutureOr<void> _onBreakHistoryDataLoad(
      GetBreakHistoryData event, Emitter<BreakState> emit) async {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    emit(
        state.copyWith(status: NetworkStatus.loading, currentDate: event.date));
    try {
      final BreakReportModel? breakReportModelData = await _metaClubApiClient
          .getBreakHistory(state.currentDate ?? currentDate);
      if (breakReportModelData != null) {
        emit(state.copyWith(
            status: NetworkStatus.success,
            breakReportModel: breakReportModelData));
      } else {
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onInitialBreakHistory(
      OnInitialHistoryEvent event, Emitter<BreakState> emit) {
    emit(state.copyWith(breaks: event.breaks ?? []));
  }
}
