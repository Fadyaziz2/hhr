part of'election_bloc.dart';

class ElectionState extends Equatable {
  final ElectionInfo? electionInfo;
  final NetworkStatus status;

  const ElectionState({this.electionInfo, this.status = NetworkStatus.initial});

  ElectionState copyWith({ElectionInfo? electionInfo, NetworkStatus? status}) {
    return ElectionState(electionInfo: electionInfo ?? this.electionInfo, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [electionInfo, status];
}