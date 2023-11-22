part of 'visit_bloc.dart';

abstract class VisitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateRescheduleApi extends VisitEvent {
  final BodyCreateSchedule? bodyCreateSchedule;
  final BuildContext context;

  CreateRescheduleApi({this.bodyCreateSchedule, required this.context});

  @override
  List<Object?> get props => [bodyCreateSchedule];
}

class VisitListApi extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class VisitCreateNoteApi extends VisitEvent {
  final BodyVisitNote? bodyVisitNote;
  final BuildContext context;

  VisitCreateNoteApi({this.bodyVisitNote, required this.context});

  @override
  List<Object?> get props => [bodyVisitNote];
}

class VisitGoToPosition extends VisitEvent {
  final LatLng latLng;
  final GoogleMapController controller;

  VisitGoToPosition({required this.latLng, required this.controller});

  @override
  List<Object?> get props => [latLng, controller];
}

class VisitDetailsApi extends VisitEvent {
  final int? visitId;

  VisitDetailsApi(this.visitId);

  @override
  List<Object?> get props => [visitId];
}

class HistoryListApi extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class SelectDatePicker extends VisitEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

class SelectMonthPicker extends VisitEvent {
  final BuildContext context;

  SelectMonthPicker(this.context);

  @override
  List<Object> get props => [];
}

class CreateVisitEvent extends VisitEvent {
  final BodyCreateVisit bodyCreateVisit;
  final BuildContext context;

  CreateVisitEvent({
    required this.bodyCreateVisit,
    required this.context,
  });

  @override
  List<Object> get props => [bodyCreateVisit];
}
