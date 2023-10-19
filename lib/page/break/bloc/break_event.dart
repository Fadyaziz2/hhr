part of 'break_bloc.dart';

abstract class BreakEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnCustomTimerStart extends BreakEvent{
  final int hour;
  final int min;
  final int sec;

  OnCustomTimerStart({required this.hour,required this.min,required this.sec});

  @override
  List<Object?> get props => [hour,min, sec];
}

class OnBreakBackEvent extends BreakEvent{

}
