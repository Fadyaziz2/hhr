part of 'acts_regulation_bloc.dart';

abstract class ActsRegulationEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class ActsRequestLoadRequest extends ActsRegulationEvent{}