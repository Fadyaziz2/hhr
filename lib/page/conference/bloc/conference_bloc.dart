import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/enum.dart';

part 'conference_event.dart';

part 'conference_state.dart';

class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  final MetaClubApiClient metaClubApiClient;

  ConferenceBloc({required this.metaClubApiClient})
      : super(const ConferenceState(status: NetworkStatus.loading)) {
    on<ConferenceInitialDataRequest>(_onConferenceInitialDataRequest);
  }

  FutureOr<void> _onConferenceInitialDataRequest(
      ConferenceInitialDataRequest event, Emitter<ConferenceState> emit) async {
    try {
      final conference = await metaClubApiClient.getConferenceList();
      emit(state.copyWith(
          status: NetworkStatus.success, conference: conference));
    } on Exception catch (e) {
      emit(const ConferenceState(status: NetworkStatus.failure));
      throw NetworkRequestFailure(e.toString());
    }
  }
}
