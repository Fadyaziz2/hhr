part of 'event_bloc.dart';

abstract class EventEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class EventLoadRequest extends EventEvent{}

class EventGoingButton extends EventEvent{
  final int eventId;

  EventGoingButton({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

class EventAppreciateButton extends EventEvent{
  final int eventId;

  EventAppreciateButton({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}