part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadSettings extends HomeEvent{}

class LoadHomeData extends HomeEvent{}

class OnHomeRefresh extends HomeEvent{}

class OnSwitchPressed extends HomeEvent{
  final User? user;
  final LocationServiceProvider locationProvider;
  OnSwitchPressed({required this.user,required this.locationProvider});
}

class OnLocationEnabled extends HomeEvent{
  final User user;
  final LocationServiceProvider locationProvider;

  OnLocationEnabled({required this.user,required this.locationProvider});
}

