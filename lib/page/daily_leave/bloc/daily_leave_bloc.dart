import 'dart:async';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/daily_leave/model/leave_type_model.dart';

import '../../../res/date_utils.dart';
import '../../../res/enum.dart';
import '../../../res/widgets/month_picker_dialog/month_picker_dialog.dart';

class DailyLeaveBloc extends Bloc<DailyLeaveEvent, DailyLeaveState> {
  final MetaClubApiClient _metaClubApiClient;
  final reasonTextController = TextEditingController();

  DailyLeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const DailyLeaveState(status: NetworkStatus.initial)) {
    on<DailyLeaveSummary>(_dailyLeaveSummary);
    on<SelectDatePickerDailyLeave>(_onSelectDatePicker);
    on<SelectApproxTime>(_onSelectTimePicker);
    on<SelectLeaveType>(_onSelectLeaveType);
    on<ApplyLeave>(_onApplyLeave);
  }

  ///leave type defined
  List<LeaveTypeModel>? leave = [
    LeaveTypeModel(title: 'Early Leave', value: 'early_leave'),
    LeaveTypeModel(title: 'Late Arrive', value: 'late_arrive'),
  ];

  FutureOr<void> _onSelectDatePicker(
      SelectDatePickerDailyLeave event, Emitter<DailyLeaveState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(DailyLeaveSummary(event.userId));
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _dailyLeaveSummary(
      DailyLeaveSummary event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      DailyLeaveSummaryModel? dailyLeaveSummaryModel =
          await _metaClubApiClient.dailyLeaveSummary(event.userId, state.currentMonth ?? DateFormat('y-MM').format(DateTime.now()));
      emit(state.copyWith(
          dailyLeaveSummaryModel: dailyLeaveSummaryModel,
          status: NetworkStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }

  FutureOr<void> _onSelectLeaveType(
      SelectLeaveType event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(leaveTypeModel: event.leaveTypeModel));
  }

  FutureOr<void> _onSelectTimePicker(
      SelectApproxTime event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(approxTime: event.approxTime));
  }

  FutureOr<void> _onApplyLeave(
      ApplyLeave event, Emitter<DailyLeaveState> emit) async {emit(state.copyWith(status: NetworkStatus.loading));
    final data = {
      'approx_time': state.approxTime,
      'reason': reasonTextController.text,
      'leave_type': state.leaveTypeModel!.value
    };
    try {
      await _metaClubApiClient.postApplyLeave(data).then((value) {
        if (value['result'] == true) {
          Fluttertoast.showToast(msg: value['message']);
          add(DailyLeaveSummary(event.userId));
          Navigator.of(event.context).pop();
        }
      });
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }
}
