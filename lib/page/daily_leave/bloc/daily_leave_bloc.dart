import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';

import '../../../res/enum.dart';


class DailyLeaveBloc extends Bloc<DailyLeaveEvent, DailyLeaveState> {
  final MetaClubApiClient _metaClubApiClient;

  DailyLeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const DailyLeaveState(status: NetworkStatus.initial)) {
    on<DailyLeaveSummary>(_dailyLeaveSummary);
  }

  FutureOr<void> _dailyLeaveSummary(DailyLeaveSummary event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      DailyLeaveSummaryModel? dailyLeaveSummaryModel =   await _metaClubApiClient.dailyLeaveSummary(event.userId);
      emit(state.copyWith());
    } catch(e){
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }
}
