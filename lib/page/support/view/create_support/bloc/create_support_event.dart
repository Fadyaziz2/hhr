
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';

abstract class CreateSupportEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class GetPriority extends CreateSupportEvent {
  final BodyPrioritySupport bodyPrioritySupport;

  GetPriority({required this.bodyPrioritySupport});

  @override
  List<Object> get props => [bodyPrioritySupport];
}

class AddFile extends CreateSupportEvent {
  final BuildContext context;

  AddFile(this.context);

  @override
  List<Object> get props => [context];
}



