import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appointment_create/model/appoinment_body_model.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';

part 'appoinment_create_event.dart';
part 'appoinment_create_state.dart';

class AppoinmentCreateBloc
    extends Bloc<AppoinmentCreateEvent, AppoinmentCreatState> {
  final MetaClubApiClient _metaClubApiClient;

  AppoinmentCreateBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const AppoinmentCreatState(
          status: NetworkStatus.initial,
        )) {
    on<LoadAppoinmentCreateData>(_onAppoinmentDataLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<SelectStartTime>(_showTime);
    on<SelectEndTime>(_showEndTime);
    on<CreateButton>(_onCreateButton);
  }
  void _onAppoinmentDataLoad(LoadAppoinmentCreateData event,
      Emitter<AppoinmentCreatState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    emit(AppoinmentCreatState(
      status: NetworkStatus.success,
      currentMonth: event.date,
      startTime: event.startTime,
      endTime: event.endTime,
    ));
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<AppoinmentCreatState> emit) async {
    final date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth =
        getDateAsString(format: 'dd-MM-yyyy', dateTime: date!);
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
    // add(LoadAppoinmentCreateData(date: currentMonth));
  }

  FutureOr<void> _showTime(
      SelectStartTime event, Emitter<AppoinmentCreatState> emit) async {
    final TimeOfDay? result = await showTimePicker(
      context: event.context,
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
      SelectEndTime event, Emitter<AppoinmentCreatState> emit) async {
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

  FutureOr<void> _onCreateButton(
      CreateButton event, Emitter<AppoinmentCreatState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final response =
          await _metaClubApiClient.appoinmentCreate(data: event.appoinmentBody);
      emit(state.copyWith(status: NetworkStatus.success));
      // ignore: use_build_context_synchronously
      Navigator.pop(event.context);
    } catch (e) {
      emit(const AppoinmentCreatState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
