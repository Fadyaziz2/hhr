import 'package:equatable/equatable.dart';

abstract class SupportEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class getSupportData extends SupportEvent{}