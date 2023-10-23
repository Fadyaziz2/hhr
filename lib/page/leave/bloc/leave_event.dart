import 'package:equatable/equatable.dart';

abstract class LeaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LeaveSummaryApi extends LeaveEvent {}