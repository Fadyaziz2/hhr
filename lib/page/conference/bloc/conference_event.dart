part of 'conference_bloc.dart';

abstract class ConferenceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConferenceInitialDataRequest extends ConferenceEvent {
  ConferenceInitialDataRequest();

  @override
  List<Object?> get props => [];
}
