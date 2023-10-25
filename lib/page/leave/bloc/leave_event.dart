import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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