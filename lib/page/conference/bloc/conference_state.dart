part of 'conference_bloc.dart';

class ConferenceState extends Equatable {
  final NetworkStatus status;
  final ConferenceModel? conference;
  final String? currentMonthSchedule;

  const ConferenceState({required this.status, this.conference,this.currentMonthSchedule});

  ConferenceState copyWith(
      {NetworkStatus? status, ConferenceModel? conference,String? currentMonthSchedule}) {
    return ConferenceState(
        status: status ?? this.status,
        conference: conference ?? this.conference,currentMonthSchedule: currentMonthSchedule ?? this.currentMonthSchedule);
  }

  @override
  List<Object?> get props => [status, conference,currentMonthSchedule];
}
