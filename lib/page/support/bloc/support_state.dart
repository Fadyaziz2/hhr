import 'package:equatable/equatable.dart';
import 'package:onesthrm/res/enum.dart';

class SupportState extends Equatable {
  final NetworkStatus? status;

  const SupportState({this.status});

  SupportState copy({NetworkStatus? status}) {
    return SupportState(status: this.status);
  }

  @override
  List<Object?> get props => [status];
}
