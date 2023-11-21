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
}
