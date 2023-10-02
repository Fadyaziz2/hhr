import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/date_utils.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/month_picker_dialog/month_picker_dialog.dart';

part 'attendance_report_event.dart';
part 'attendance_report_state.dart';

var dateTime = DateTime.now();

class AttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  final MetaClubApiClient _metaClubApiClient;

  AttendanceReportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const AttendanceReportState(status: NetworkStatus.initial)) {
    on<GetAttendanceReportData>(_onAttendanceLoad);
  }

  FutureOr<void> _onAttendanceLoad(GetAttendanceReportData event,
      Emitter<AttendanceReportState> emit) async {
    final currentDate = DateFormat('y-MM').format(DateTime.now());

    emit(state.copy(status: NetworkStatus.loading, currentMonth: event.date));

    // try {
    //   final success = await _metaClubApiClient.getSupport(
    //       getSelectedIndex(filter: state.filter),
    //       state.currentMonth ?? currentDate);
    //   if (success != null) {
    //     emit(state.copy(
    //         status: NetworkStatus.success,
    //         supportListModel: success,
    //         filter: event.filter,
    //         currentMonth: event.date));
    //   } else {
    //     emit(state.copy(
    //         status: NetworkStatus.failure,
    //         filter: event.filter,
    //         currentMonth: event.date));
    //   }
    // } catch (e) {
    //   emit(state.copy(
    //       status: NetworkStatus.failure,
    //       filter: event.filter,
    //       currentMonth: event.date));
    //   throw NetworkRequestFailure(e.toString());
    // }
  }

  FutureOr<void> _onSelectDatePicker(
      SelectDatePicker event, Emitter<AttendanceReportState> emit) async {
    var date = await showMonthPicker(
      context: event.context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      // initialDate: date == null ? DateTime.now() :date! ,
      initialDate: dateTime,
      locale: const Locale("en"),
    );

    dateTime = date!;
    String? currentMonth = getDateAsString(format: 'y-MM', dateTime: date);
    // add(GetSupportData(date: currentMonth));
  }
}
