part of 'election_bloc.dart';

abstract class ElectionEvent extends Equatable {
  const ElectionEvent();

  @override
  List<Object?> get props => [];
}

class ElectionLoadRequest extends ElectionEvent {}

class VoteSubmitted extends ElectionEvent {
  final int electionId, positionId, candidateId;
  final BuildContext context;

  const VoteSubmitted(
      {required this.electionId,
      required this.positionId,
        required this.context,
      required this.candidateId});

  @override
  List<Object?> get props => [electionId, positionId, candidateId];
}
