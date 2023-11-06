import 'package:equatable/equatable.dart';

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