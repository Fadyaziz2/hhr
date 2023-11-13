import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/page/daily_leave/model/leave_list_model.dart';
import 'package:onesthrm/page/daily_leave/model/leave_type_model.dart';

import '../../../res/date_utils.dart';
import '../../../res/enum.dart';

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
    on<SelectEmployee>(_selectEmployee);
  }

  ///leave type defined
  List<LeaveTypeModel>? leave = [
    LeaveTypeModel(title: 'Early Leave', value: 'early_leave'),
    LeaveTypeModel(title: 'Late Arrive', value: 'late_arrive'),
  ];

  FutureOr<void> _onSelectDatePicker(
      SelectDatePickerDailyLeave event, Emitter<DailyLeaveState> emit) async {
    var date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM-d', dateTime: date);
    add(DailyLeaveSummary(event.userId));
    emit(state.copyWith(
        status: NetworkStatus.success, currentMonth: currentMonth));
  }

  FutureOr<void> _dailyLeaveSummary(
      DailyLeaveSummary event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(
        status: NetworkStatus.loading,
        currentMonth:
            state.currentMonth ?? DateFormat('y-MM-d').format(DateTime.now())));
    try {
      DailyLeaveSummaryModel? dailyLeaveSummaryModel = await _metaClubApiClient
          .dailyLeaveSummary(event.userId, state.currentMonth);
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
      ApplyLeave event, Emitter<DailyLeaveState> emit) async {
    if (state.approxTime != null && state.leaveTypeModel != null) {
      emit(state.copyWith(status: NetworkStatus.loading));
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
    } else {
      Fluttertoast.showToast(msg: 'Select leave type and time');
    }
  }

  FutureOr<void> _selectEmployee(
      SelectEmployee event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(selectEmployee: event.selectEmployee));
    add(DailyLeaveSummary(event.selectEmployee.id!));
  }

/*  FutureOr<void> _onLeaveTypeList(LeaveTypeList event, Emitter<DailyLeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final LeaveTypeListModel? leaveTypeListData = await _metaClubApiClient.dailyLeaveSummaryStaffView(userId: state.selectEmployee?.id.toString() ??  event.userId, month: state.currentMonth, leaveStatus: event.leaveStatus, leaveType: event.leaveType);
      if (leaveTypeListData != null) {
        emit(state.copyWith(status: NetworkStatus.success, leaveTypeListData: leaveTypeListData));
      } else {
        emit(state.copyWith(status: NetworkStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }*/

  Future<LeaveTypeListModel?> onLeaveTypeList(
      LeaveListModel leaveListModel) async {
    try {
      final leaveTypeListData =
          await _metaClubApiClient.dailyLeaveSummaryStaffView(
              userId:
                  state.selectEmployee?.id.toString() ?? leaveListModel.userId,
              // month: state.currentMonth,
              month: leaveListModel.month,
              leaveStatus: leaveListModel.leaveStatus,
              leaveType: leaveListModel.leaveType);
      return leaveTypeListData;
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
    return null;
  }
}
