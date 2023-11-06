import 'package:equatable/equatable.dart';
import 'package:onesthrm/res/enum.dart';

class DailyLeaveState extends Equatable {
  final NetworkStatus? status;

  const DailyLeaveState({this.status});

  DailyLeaveState copyWith({NetworkStatus? status}) {
    return DailyLeaveState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
