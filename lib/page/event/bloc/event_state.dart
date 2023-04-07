part of 'event_bloc.dart';

class EventState extends Equatable {
  final Events? events;
  final NetworkStatus status;

  const EventState({this.events, this.status = NetworkStatus.initial});

  EventState copyWith({required Events? events, required NetworkStatus? status}) {
    return EventState(events: events ?? this.events, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [events, status];
}

