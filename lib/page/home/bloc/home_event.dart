import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

 class LoadSettings extends HomeEvent{}

 class OnHomeRefresh extends HomeEvent{

}

