import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

abstract class LeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaveSummaryApi extends LeaveEvent {
  BuildContext context;

  LeaveSummaryApi(this.context);

  @override
  List<Object> get props => [context];
}

class LeaveRequest extends LeaveEvent {
  BuildContext context;
  String pickedDate;

  LeaveRequest(this.context,this.pickedDate);

  @override
  List<Object> get props => [context,pickedDate];
}

class LeaveRequestTypeEven extends LeaveEvent {
  BuildContext context;

  LeaveRequestTypeEven(this.context);

  @override
  List<Object> get props => [context];
}

class SelectedRequestType extends LeaveEvent {
  BuildContext context;
  AvailableLeaveType availableLeaveType;

  SelectedRequestType(this.context, this.availableLeaveType);

  @override
  List<Object> get props => [context, availableLeaveType];
}

class SelectedCalendar extends LeaveEvent {
  String startDate;
  String endDate;

  SelectedCalendar(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class SelectEmployee extends LeaveEvent {
  final BuildContext context;
  final PhoneBookUser? selectEmployee;
  SelectEmployee(this.context, this.selectEmployee);
  @override
  List<Object> get props => [
    context,
  ];
}

class SubmitLeaveRequest extends LeaveEvent {
  final BuildContext context;
  final BodyCreateLeaveModel bodyCreateLeaveModel;
  final String pickedDate;

  SubmitLeaveRequest({required this.bodyCreateLeaveModel,required this.context,required this.pickedDate});

  @override
  List<Object> get props => [bodyCreateLeaveModel, context,pickedDate];
}

class SelectDatePicker extends LeaveEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}
