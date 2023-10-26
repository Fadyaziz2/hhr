import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_event.dart';
import 'package:onesthrm/page/leave/bloc/leave_state.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final MetaClubApiClient _metaClubApiClient;

  LeaveBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const LeaveState(status: NetworkStatus.initial)) {
    on<LeaveSummaryApi>(_leaveSummaryApi);
    on<LeaveRequest>(_leaveRequest);
  }

  FutureOr<void> _leaveRequest(
      LeaveRequest event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final user = event.context.read<AuthenticationBloc>().state.data;
      LeaveRequestModel? leaveRequestResponse =
          await _metaClubApiClient.leaveRequestApi(user?.user?.id);

      emit(state.copyWith(
          leaveRequestModel: leaveRequestResponse,
          status: NetworkStatus.success));

      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }

  FutureOr<void> _leaveSummaryApi(
      LeaveSummaryApi event, Emitter<LeaveState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final user = event.context.read<AuthenticationBloc>().state.data;
      LeaveSummaryModel? leaveSummaryResponse =
          await _metaClubApiClient.leaveSummaryApi(user?.user?.id);

      emit(state.copyWith(
          leaveSummaryModel: leaveSummaryResponse,
          status: NetworkStatus.success));

      return null;
    } catch (e) {
      emit(state.copyWith(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
