

import 'package:equatable/equatable.dart';
import 'package:onesthrm/res/enum.dart';

class CreateSupportState extends Equatable {
  final NetworkStatus? status;

  const CreateSupportState({this.status});

  CreateSupportState copy({NetworkStatus? status}) {
    return CreateSupportState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
