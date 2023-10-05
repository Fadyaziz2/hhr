import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';
import 'package:user_repository/user_repository.dart';

part 'attendance_report_event.dart';
part 'attendance_report_state.dart';

class AttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  final MetaClubApiClient metaClubApiClient;
  final LoginData user;
  var dateTime = DateTime.now();

  AttendanceReportBloc({required this.metaClubApiClient, required this.user})
      : super(const AttendanceReportState(status: NetworkStatus.initial)) {
    on<GetAttendanceReportData>(_onAttendanceLoad);
    on<SelectDatePicker>(_onSelectDatePicker);
  }

  FutureOr<void> _onAttendanceLoad(GetAttendanceReportData event,
      Emitter<AttendanceReportState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());

    final data = {'month': event.date ?? currentDate};
    try {
      final report =
          await metaClubApiClient.getAttendanceReport(body: data, userId: user.user!.id);
      emit(state.copyWith(
          status: NetworkStatus.success, attendanceReport: report));
    } on Exception catch (e) {
      emit(const AttendanceReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<AttendanceReportState> emit) async {

    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: dateTime,
      locale: const Locale("en"),
    );

    dateTime = date!;
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    add(GetAttendanceReportData(date: currentMonth));
  }
}
