part of "meeting_bloc.dart";

abstract class MeetingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MeetingListEvent extends MeetingEvent {
  @override
  List<Object> get props => [];
}
class SelectDatePicker extends MeetingEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

