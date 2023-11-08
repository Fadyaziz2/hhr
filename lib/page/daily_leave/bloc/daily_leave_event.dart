import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/daily_leave/model/leave_type_model.dart';

abstract class DailyLeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DailyLeaveSummary extends DailyLeaveEvent {
  final int userId;

  DailyLeaveSummary(this.userId);

  @override
  List<Object> get props => [userId];
}

class SelectDatePickerDailyLeave extends DailyLeaveEvent {
  final int userId;
  final BuildContext context;

  SelectDatePickerDailyLeave(this.userId, this.context);

  @override
  List<Object> get props => [userId];
}

class SelectApproxTime extends DailyLeaveEvent {
  final String approxTime;

  SelectApproxTime(this.approxTime);

  @override
  List<Object?> get props => [approxTime];
}

class SelectLeaveType extends DailyLeaveEvent {
  final LeaveTypeModel leaveTypeModel;

  SelectLeaveType({required this.leaveTypeModel});

  @override
  List<Object?> get props => [leaveTypeModel];
}

class ApplyLeave extends DailyLeaveEvent{
  final int userId;
  final BuildContext context;
  ApplyLeave({required this.userId, required this.context});

  @override
  List<Object?> get props => [userId, context];
}
