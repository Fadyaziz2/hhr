import 'dart:async';
import 'package:custom_timer/custom_timer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/const.dart';
import '../../app/global_state.dart';
part 'break_event.dart';
part 'break_state.dart';

class BreakBloc extends Bloc<BreakEvent,BreakState>{

  final MetaClubApiClient _metaClubApiClient;

  BreakBloc({required MetaClubApiClient metaClubApiClient}): _metaClubApiClient = metaClubApiClient, super(const BreakState()){
    on<OnCustomTimerStart>(_onCustomTimerStart);
    on<OnBreakBackEvent>(_onBreakBack);
  }

  FutureOr<void> _onCustomTimerStart(OnCustomTimerStart event, Emitter<BreakState> emit) {
    emit(state.copyWith(isTimerStart: !state.isTimerStart));
  }

  FutureOr<void> _onBreakBack(OnBreakBackEvent event, Emitter<BreakState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    Break? data = await _metaClubApiClient.backBreak();
    globalState.set(breakTime, data?.data?.breakTime);
    globalState.set(backTime, data?.data?.backTime);
    globalState.set(breakStatus, data?.data?.status);
    globalState.set(hour, '0');
    globalState.set(min, '0');
    globalState.set(sec, '0');
    add(OnCustomTimerStart(hour: 0, min: 0, sec: 0));
    emit(state.copyWith(status: NetworkStatus.success,breakBack: data));
  }
}