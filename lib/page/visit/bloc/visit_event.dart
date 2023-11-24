part of 'visit_bloc.dart';

abstract class VisitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitCancelApi extends VisitEvent {
  final BodyVisitCancel? bodyVisitCancel;
  final BuildContext context;

  VisitCancelApi({this.bodyVisitCancel, required this.context});

  @override
  List<Object?> get props => [bodyVisitCancel];
}

class VisitStatusApi extends VisitEvent {
  final BodyVisitCancel? bodyVisitCancel;
  final BuildContext context;

  VisitStatusApi({this.bodyVisitCancel, required this.context});

  @override
  List<Object?> get props => [bodyVisitCancel];
}

class UploadFile extends VisitEvent {
  final File file;
  final BodyImageUpload bodyImageUpload;

  UploadFile({required this.file, required this.bodyImageUpload});

  @override
  List<Object?> get props => [file.path, bodyImageUpload];
}

class VisitUploadPhoto extends VisitEvent {
  final BuildContext context;
  final BodyImageUpload bodyImageUpload;

  VisitUploadPhoto({required this.context,required this.bodyImageUpload});

  @override
  List<Object?> get props => [bodyImageUpload];
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

class VisitUpdate extends VisitEvent {
  final BodyUpdateVisit? bodyUpdateVisit;
  final BuildContext context;

  VisitUpdate({this.bodyUpdateVisit, required this.context});

  @override
  List<Object?> get props => [bodyUpdateVisit];
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
  final int visitId;
  final double? latitude;
  final double? longitude;

  VisitDetailsApi({required this.visitId, this.latitude, this.longitude});

  @override
  List<Object?> get props => [visitId, latitude, longitude];
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
