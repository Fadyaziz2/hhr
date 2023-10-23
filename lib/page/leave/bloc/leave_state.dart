import 'package:equatable/equatable.dart';
import 'package:onesthrm/res/enum.dart';

class LeaveState extends Equatable {
  final NetworkStatus status;

  const LeaveState({this.status = NetworkStatus.initial});

  @override
  List<Object?> get props => [];
}
