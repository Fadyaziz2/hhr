import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final MetaClubApiClient _metaClubApiClient;

  ExpenseBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const ExpenseState(status: NetworkStatus.initial)) {
    on<GetExpenseData>(_onAppointmentLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onAppointmentLoad(
      GetExpenseData event, Emitter<ExpenseState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    emit(ExpenseState(status: NetworkStatus.loading, currentMonth: event.date));
    try {
      final MeetingsListModel? success = await _metaClubApiClient
          .getMeetingsItem(state.currentMonth ?? currentDate);
      if (success != null) {
        emit(ExpenseState(
            status: NetworkStatus.success, currentMonth: event.date));
      } else {
        emit(ExpenseState(
            status: NetworkStatus.failure, currentMonth: event.date));
      }
    } catch (e) {
      emit(ExpenseState(
          status: NetworkStatus.failure, currentMonth: event.date));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<ExpenseState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(GetExpenseData(date: currentMonth));
  }
}
