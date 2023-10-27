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
    on<GetExpenseData>(_onExpenseDataLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
    on<SelectPaymentType>(_onSelectedPaymentType);
    on<SelectStatus>(_onSelectedStatus);
    on<ExpenseCategory>(_onExpenseCategoryLoad);
    on<SelectedCategory>(_onSelectedCategory);
  }

  FutureOr<void> _onExpenseDataLoad(
      GetExpenseData event, Emitter<ExpenseState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());
    emit(state.copy(
        status: NetworkStatus.loading,
        currentMonth: event.date,
        statusType: event.statusTypeId));
    try {
      final ResponseExpenseList? responseExpenseList =
          await _metaClubApiClient.getExpenseItem(
              state.currentMonth ?? currentDate,
              event.paymentId ?? state.paymentId,
              event.statusTypeId ?? state.statusType);
      if (responseExpenseList != null) {
        emit(state.copy(
            status: NetworkStatus.success,
            responseExpenseList: responseExpenseList,
            currentMonth: event.date,
            paymentId: event.paymentId,
            statusType: event.statusTypeId));
      } else {
        emit(state.copy(
            status: NetworkStatus.failure,
            currentMonth: event.date,
            paymentId: event.paymentId,
            responseExpenseList: responseExpenseList,
            statusType: event.statusTypeId));
      }
    } catch (e) {
      emit(state.copy(
          status: NetworkStatus.failure,
          currentMonth: event.date,
          paymentId: event.paymentId,
          statusType: event.statusTypeId));
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

  FutureOr<void> _onSelectedPaymentType(
      SelectPaymentType event, Emitter<ExpenseState> emit) {
    emit(state.copy(paymentTypeName: event.paymentType));
    int paymentTypeId;

    if (event.paymentType == 'Paid') {
      paymentTypeId = 8;
    } else {
      paymentTypeId = 9;
    }

    add(GetExpenseData(paymentId: paymentTypeId.toString()));
  }

  FutureOr<void> _onSelectedStatus(
      SelectStatus event, Emitter<ExpenseState> emit) {
    emit(state.copy(
      statusTypeName: event.statusType,
    ));
    int status;
    if (event.statusType == 'Pending') {
      status = 2;
    } else if (event.statusType == 'Approved') {
      status = 5;
    } else {
      status = 6;
    }
    add(GetExpenseData(
      statusTypeId: status.toString(),
    ));
  }

  FutureOr<void> _onExpenseCategoryLoad(
      ExpenseCategory event, Emitter<ExpenseState> emit) async {
    emit(state.copy(
      status: NetworkStatus.loading,
    ));
    try {
      final ExpenseCategoryModel? expenseCategoryData =
          await _metaClubApiClient.getExpenseCategory();
      if (expenseCategoryData != null) {
        emit(state.copy(
            status: NetworkStatus.success,
            expenseCategoryData: expenseCategoryData));
      } else {
        emit(state.copy(
            status: NetworkStatus.failure,
            expenseCategoryData: expenseCategoryData));
      }
    } catch (e) {
      emit(state.copy(
        status: NetworkStatus.failure,
      ));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectedCategory(
      SelectedCategory event, Emitter<ExpenseState> emit) {
    emit(state.copy(selectedCategoryId: event.selectedCategory));
  }
}
