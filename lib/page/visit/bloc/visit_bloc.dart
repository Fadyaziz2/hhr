import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'visit_event.dart';

part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  final MetaClubApiClient _metaClubApiClient;

  VisitBloc({required MetaClubApiClient metaClubApiClient})
      : _metaClubApiClient = metaClubApiClient,
        super(const VisitState()) {
    on<VisitListApi>(_visitListApi);
  }

  FutureOr<void> _visitListApi(VisitListApi event, Emitter<VisitState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    try {
      final visitResponse = await _metaClubApiClient.getVisitList();
      emit(state.copyWith(
          status: NetworkStatus.success, visitListResponse: visitResponse));
    } on Exception catch (e) {
      emit(const VisitState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
