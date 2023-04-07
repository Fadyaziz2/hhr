import 'package:club_application/res/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/models/election_info.dart';

part 'election_event.dart';

part 'election_state.dart';

class ElectionBloc extends Bloc<ElectionEvent, ElectionState> {
  final MetaClubApiClient clubApiClient;

  ElectionBloc({required this.clubApiClient})
      : super(const ElectionState(status: NetworkStatus.initial)) {
    on<ElectionLoadRequest>(_onElectionDataRequest);
    on<VoteSubmitted>(_onVoteSubmitted);
  }

  void _onVoteSubmitted(VoteSubmitted event, Emitter<ElectionState> emit) async{
    final data = {
      "election_id": event.electionId,
      "position_id": event.positionId,
      "elected_id": event.candidateId,
    };
    if (kDebugMode) {
      print(data.toString());
    }
    try {
      final election = await clubApiClient.postSubmitVote(data);
      add(ElectionLoadRequest());
    } catch (_) {
      emit(const ElectionState(status: NetworkStatus.failure));
    }
  }

  void _onElectionDataRequest(ElectionLoadRequest event, Emitter<ElectionState> emit) async {
    emit(const ElectionState(status: NetworkStatus.loading));
    try {
      final election = await clubApiClient.getElectionInfo();
      emit(ElectionState(electionInfo: election, status: NetworkStatus.success));
    } catch (_) {
      emit(const ElectionState(status: NetworkStatus.failure));
    }
  }
}
