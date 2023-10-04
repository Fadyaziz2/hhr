part of 'appoinment_create_bloc.dart';

abstract class AppoinmentCreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAppoinmentCreateData extends AppoinmentCreateEvent {
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? employeeName;
  LoadAppoinmentCreateData(
      {this.date, this.startTime, this.endTime, this.employeeName});
  @override
  List<Object> get props => [];
}

class SelectDatePicker extends AppoinmentCreateEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class SelectStartTime extends AppoinmentCreateEvent {
  final BuildContext context;

  SelectStartTime(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class SelectEmployee extends AppoinmentCreateEvent {
  final BuildContext context;
  final PhonebookUser? selectEmployee;
  SelectEmployee(this.context, this.selectEmployee);
  @override
  List<Object> get props => [
        context,
      ];
}

class SelectEndTime extends AppoinmentCreateEvent {
  final BuildContext context;
  SelectEndTime(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class SelectImage extends AppoinmentCreateEvent {
  final BuildContext context;
  SelectImage(
    this.context,
  );
  @override
  List<Object> get props => [context];
}

class CreateButton extends AppoinmentCreateEvent {
  final AppoinmentBody appoinmentBody;
  final BuildContext context;
  CreateButton(this.context, this.appoinmentBody);
  @override
  List<Object> get props => [context, appoinmentBody];
}
