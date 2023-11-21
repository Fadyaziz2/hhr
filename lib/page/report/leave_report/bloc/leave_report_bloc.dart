import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'leave_report_event.dart';
part 'leave_report_state.dart';

class LeaveReportBloc extends Bloc<LeaveReportEvent, LeaveReportState> {
  final MetaClubApiClient metaClubApiClient;

  LeaveReportBloc({required this.metaClubApiClient})
      : super(const LeaveReportState(status: NetworkStatus.initial)) {
    on<GetLeaveReportSummary>(_onLeaveReportSummary);
    on<FilterLeaveReportSummary>(_onFilterLeaveReportSummary);
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
      LeaveSummaryModel? leaveSummaryResponse =
          await metaClubApiClient.leaveSummaryApi(event.selectedEmployee.id);
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
