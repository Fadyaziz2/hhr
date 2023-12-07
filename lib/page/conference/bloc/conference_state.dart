part of 'conference_bloc.dart';

class ConferenceState extends Equatable {
  final NetworkStatus status;
  final ConferenceModel? conference;

  const ConferenceState({required this.status, this.conference});

  ConferenceState copyWith(
      {NetworkStatus? status, ConferenceModel? conference}) {
    return ConferenceState(
        status: status ?? this.status,
        conference: conference ?? this.conference);
  }

  @override
  List<Object?> get props => [status, conference];
}
