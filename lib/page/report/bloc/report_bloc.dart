import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final MetaClubApiClient metaClubApiClient;

  ReportBloc({required this.metaClubApiClient})
      : super(const ReportState(status: NetworkStatus.initial)) {
    on<GetReportData>(_onGetReportData);
    on<GetLeaveReportSummary>(_onLeaveReportSummary);
    on<FilterLeaveReportSummary>(_onFilterLeaveReportSummary);
  }

  FutureOr<void> _onGetReportData(
      GetReportData event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    final data = {'date': currentDate};
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

  FutureOr<void> _onLeaveReportSummary(
      GetLeaveReportSummary event, Emitter<ReportState> emit) async {
    final currentDate = DateFormat('y-M-d', "en").format(DateTime.now());

    try {
      final leaveSummaryData =
          await metaClubApiClient.leaveReportSummaryApi(currentDate);
      emit(state.copyWith(
          status: NetworkStatus.success,
          leaveReportSummaryModel: leaveSummaryData));
    } on Exception catch (e) {
      emit(const ReportState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _onFilterLeaveReportSummary(
      FilterLeaveReportSummary event, Emitter<ReportState> emit) async {
    try {
      LeaveSummaryModel? leaveSummaryResponse =
          await metaClubApiClient.leaveSummaryApi(event.selectedEmployeeId);
      emit(state.copyWith(
          filterLeaveSummaryResponse: leaveSummaryResponse,
          status: NetworkStatus.success));
      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
