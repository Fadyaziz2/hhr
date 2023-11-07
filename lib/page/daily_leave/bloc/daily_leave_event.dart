import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  SelectDatePickerDailyLeave(this.userId,this.context);

  @override
  List<Object> get props => [userId];
}