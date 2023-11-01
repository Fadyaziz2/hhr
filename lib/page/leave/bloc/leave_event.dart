part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LeaveSummaryApi extends LeaveEvent {
  final int userId;

  LeaveSummaryApi(this.userId);

  @override
  List<Object> get props => [];
}

class LeaveRequest extends LeaveEvent {
  final int userId;

  LeaveRequest(this.userId);

  @override
  List<Object> get props => [userId];
}

class LeaveRequestTypeEven extends LeaveEvent {
  final int userId;

  LeaveRequestTypeEven(this.userId);

  @override
  List<Object> get props => [userId];
}

class SelectedRequestType extends LeaveEvent {
  final AvailableLeaveType availableLeaveType;

  SelectedRequestType(this.availableLeaveType);

  @override
  List<Object> get props => [availableLeaveType];
}

class SelectedCalendar extends LeaveEvent {
  final String startDate;
  final String endDate;

  SelectedCalendar(this.startDate, this.endDate);

  @override
  List<Object> get props => [startDate, endDate];
}

class SelectEmployee extends LeaveEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee( this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}

class SubmitLeaveRequest extends LeaveEvent {
  final BuildContext context;
  final BodyCreateLeaveModel bodyCreateLeaveModel;
  final String pickedDate;

  SubmitLeaveRequest(
      {required this.bodyCreateLeaveModel,
      required this.context,
      required this.pickedDate});

  @override
  List<Object> get props => [bodyCreateLeaveModel, pickedDate];
}

class SelectDatePicker extends LeaveEvent {
  final int userId;
  final BuildContext context;
  SelectDatePicker(this.userId,this.context);

  @override
  List<Object> get props => [userId];
}

class LeaveDetailsEven extends LeaveEvent {
  final int requestId;
  final int userId;

  LeaveDetailsEven(this.requestId, this.userId);

  @override
  List<Object> get props => [requestId, userId];
}
class CancelLeaveRequest extends LeaveEvent {
  final int requestID;
  final BuildContext context;
  CancelLeaveRequest(this.requestID,this.context);
  @override
  List<Object> get props => [requestID, context];

}
