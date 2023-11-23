import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'leave_report_event.dart';
part 'leave_report_state.dart';

class LeaveReportBloc extends Bloc<LeaveReportEvent, LeaveReportState> {
  final MetaClubApiClient metaClubApiClient;
  int userId;

  LeaveReportBloc({required this.metaClubApiClient, required this.userId})
      : super(const LeaveReportState(status: NetworkStatus.initial)) {
    on<GetLeaveReportSummary>(_onLeaveReportSummary);
    on<FilterLeaveReportSummary>(_onFilterLeaveReportSummary);
    on<SelectMonthPicker>(_onSelectMonthPicker);
    on<LeaveRequest>(_leaveRequest);
    on<SelectLeaveEmployee>(_selectEmployee);
  }

  Future<SummaryAttendanceToList?> getSummaryToList(
      {required String type}) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final data = {'type': type, 'date': currentDate};
    try {
      final response =
          await metaClubApiClient.getAttendanceSummaryToList(body: data);
      return response;
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onLeaveReportSummary(
      GetLeaveReportSummary event, Emitter<LeaveReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    try {
      final leaveSummaryData =
          await metaClubApiClient.leaveReportSummaryApi(currentDate);
      emit(state.copyWith(
          status: NetworkStatus.success,
          leaveReportSummaryModel: leaveSummaryData));
    } on Exception catch (e) {
      emit(const LeaveReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onFilterLeaveReportSummary(
      FilterLeaveReportSummary event, Emitter<LeaveReportState> emit) async {
    emit(state.copyWith(selectedEmployeeName: event.selectedEmployee));
    try {
      LeaveSummaryModel? leaveSummaryResponse = await metaClubApiClient
          .leaveSummaryApi(event.selectedEmployee?.id ?? userId);
      emit(state.copyWith(
          filterLeaveSummaryResponse: leaveSummaryResponse,
          status: NetworkStatus.success));
      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectMonthPicker(
      SelectMonthPicker event, Emitter<LeaveReportState> emit) async {
    final date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(LeaveRequest(date: currentMonth
        // userId: state.selectedEmployee?.id ?? event.userId,
        // date: currentMonth
        ));
  }

  FutureOr<void> _selectEmployee(
      SelectLeaveEmployee event, Emitter<LeaveReportState> emit) async {
    final currentMonth = DateFormat('y-MM', "en").format(DateTime.now());
    emit(state.copyWith(
        selectedEmployee: event.selectEmployee,
        selectMonth: state.selectMonth ?? currentMonth));

    add(LeaveRequest(
        // userId: event.selectEmployee.id!,
        // date: state.selectMonth ?? currentMonth
        ));
  }

  FutureOr<void> _leaveRequest(
      LeaveRequest event, Emitter<LeaveReportState> emit) async {
    final currentMonth = DateFormat('y-MM', "en").format(DateTime.now());
    emit(state.copyWith(
      status: NetworkStatus.loading,
      selectMonth: event.date,
    ));
    try {
      LeaveRequestModel? leaveRequestResponse =
          await metaClubApiClient.leaveRequestApi(
              state.selectedEmployee?.id ?? userId,
              state.selectMonth ?? currentMonth);
      emit(state.copyWith(
          leaveRequestModel: leaveRequestResponse,
          status: NetworkStatus.success));
      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
