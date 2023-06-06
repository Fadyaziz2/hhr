part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

 class LoadSettings extends HomeEvent{}

class LoadHomeData extends HomeEvent{}

 class OnHomeRefresh extends HomeEvent{

}

