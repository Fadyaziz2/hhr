import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

abstract class LoadSettings extends HomeEvent{}

abstract class OnHomeRefresh extends HomeEvent{

}

