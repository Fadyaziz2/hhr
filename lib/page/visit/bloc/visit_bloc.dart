import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/date_utils.dart';

part 'visit_event.dart';

part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final MetaClubApiClient _metaClubApiClient;

  VisitBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const VisitState()) {
    on<VisitListApi>(_visitListApi);
    on<HistoryListApi>(_historyListApi);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<CreateVisitEvent>(_onCreateVisitEvent);
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<VisitState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentDate =
        getDateAsString(format: 'yyyy-MM-dd', dateTime: date!);
    emit(state.copyWith(
        status: NetworkStatus.success,
        currentDate: currentDate,
        isDateEnable: false));
  }

  FutureOr<void> _historyListApi(
      HistoryListApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final historyResponse =
          await _metaClubApiClient.getHistoryList("2023-11");
      emit(state.copyWith(
          status: NetworkStatus.success, historyListResponse: historyResponse));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _visitListApi(
      VisitListApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final visitResponse = await _metaClubApiClient.getVisitList();
      emit(state.copyWith(
          status: NetworkStatus.success, visitListResponse: visitResponse));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onCreateVisitEvent(
      CreateVisitEvent event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading, isDateEnable: false));
    try {
      if (state.currentDate?.isNotEmpty == true) {
        await _metaClubApiClient
            .createVisitApi(bodyCreateVisit: event.bodyCreateVisit)
            .then((success) {
          if (success) {
            Fluttertoast.showToast(msg: "Visit Create Successfully");
            emit(state.copyWith(
                status: NetworkStatus.success,
                isDateEnable: false));
            add(VisitListApi());
            Navigator.pop(event.context);
          } else {
            emit(state.copyWith(status: NetworkStatus.failure));
            Fluttertoast.showToast(msg: "Something went wrong!");
          }
        });
      } else {
        emit(state.copyWith(status: NetworkStatus.success, isDateEnable: true));
      }
    } on Exception catch (e) {
      emit(
          const VisitState(status: NetworkStatus.failure, isDateEnable: false));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
