import 'package:equatable/equatable.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';
import 'package:onesthrm/res/enum.dart';

class CreateSupportState extends Equatable {
  final NetworkStatus? status;
  final BodyPrioritySupport? bodyPrioritySupport;
  final String? message;

  const CreateSupportState({this.status, this.bodyPrioritySupport,this.message});

  CreateSupportState copy({NetworkStatus? status, BodyPrioritySupport? bodyPrioritySupport}) {
    return CreateSupportState(
        status: status ?? this.status,
        bodyPrioritySupport: bodyPrioritySupport ?? this.bodyPrioritySupport,
    );
  }

  @override
  List<Object?> get props => [status,bodyPrioritySupport];
}
