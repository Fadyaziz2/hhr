import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'approval_event.dart';

part 'approval_state.dart';

class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState> {
  final MetaClubApiClient metaClubApiClient;

  ApprovalBloc({required this.metaClubApiClient})
      : super(const ApprovalState(status: NetworkStatus.initial)) {
    on<ApprovalInitialDataRequest>(_onApprovalInitialDataRequest);
  }

  FutureOr<void> _onApprovalInitialDataRequest(
      ApprovalInitialDataRequest event, Emitter<ApprovalState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final approval = await metaClubApiClient.getApprovalData();
      emit(state.copyWith(
          status: NetworkStatus.success, approval: approval, isLoading: false));
    } on Exception catch (e) {
      emit(const ApprovalState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }


  Future<ApprovalDetailsModel?> onApprovalDetails(
      {required String approvalId, required String approvalUserId}) async {
    return await metaClubApiClient.getApprovalListDetails(approvalId: approvalId, approvalUserId: approvalUserId);
  }
}
