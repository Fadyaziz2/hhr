import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final MetaClubApiClient metaClubApiClient;
  final int userId;

  ReportBloc({required this.metaClubApiClient, required this.userId})
      : super(const ReportState(status: NetworkStatus.initial)) {
    on<GetReportData>(_onGetReportData);
    on<SelectDate>(_onSelectDatePicker);
    on<SelectEmployee>(_selectEmployee);
    on<GetAttendanceReportData>(_onAttendanceLoad);
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDate event, Emitter<ReportState> emit) async {
    var date = await showDatePicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if(date != null){
      String? currentMonth = getDateAsString(format: 'y-MM-d', dateTime: date);
      emit(state.copyWith(
          status: NetworkStatus.success, currentMonth: currentMonth));
      if (event.isEmployeeScreen) {
        add(GetAttendanceReportData());
      } else {
        add(GetReportData());
      }
    }

  }

  FutureOr<void> _onGetReportData(
      GetReportData event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'date': state.currentMonth ?? currentDate};
    try {
      final report =
          await metaClubApiClient.getAttendanceReportSummary(body: data);
      emit(state.copyWith(
          status: NetworkStatus.success, attendanceSummary: report));
    } on Exception catch (e) {
      emit(const ReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future<SummaryAttendanceToList?> getSummaryToList(
      {required String type}) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());
    final data = {'type': type, 'date': state.currentMonth ?? currentDate};
    try {
      final response =
          await metaClubApiClient.getAttendanceSummaryToList(body: data);
      return response;
    } catch (e) {
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _selectEmployee(
      SelectEmployee event, Emitter<ReportState> emit) async {
    emit(state.copyWith(selectEmployee: event.selectEmployee));
    add(GetAttendanceReportData());
  }

  FutureOr<void> _onAttendanceLoad(
      GetAttendanceReportData event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'month': state.currentMonth ?? currentDate};
    try {
      final report = await metaClubApiClient.getAttendanceReport(
          body: data, userId: state.selectEmployee?.id ?? userId);
      emit(state.copyWith(
          status: NetworkStatus.success, attendanceReport: report));
    } on Exception catch (e) {
      emit(const ReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  Future<PhoneBookDetailsModel?> onPhoneBookDetails(
      {required String userId}) async {
    return await metaClubApiClient.getPhoneBooksUserDetails(userId: userId);
  }
}
