import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'report_event.dart';

part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final MetaClubApiClient _metaClubApiClient;

  ReportBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient, super(const ReportState(status: NetworkStatus.initial)) {
    on<GetReportData>(_onGetReportData);
  }

  FutureOr<void> _onGetReportData(
      GetReportData event, Emitter<ReportState> emit) async {}
}
