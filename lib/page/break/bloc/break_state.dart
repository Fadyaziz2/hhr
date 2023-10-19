part of 'break_bloc.dart';

class BreakState extends Equatable {
  final NetworkStatus status;
  final Break? breakBack;
  final bool isTimerStart;
  final List<Break>? breaks;

  const BreakState(
      {this.status = NetworkStatus.initial,
      this.breakBack,
      this.isTimerStart = false,this.breaks});

  BreakState copyWith({NetworkStatus? status, Break? breakBack, bool? isTimerStart,List<Break>? breaks}) {
    return BreakState(
      status: status ?? this.status,
      breakBack: breakBack ?? this.breakBack,
      isTimerStart: isTimerStart ?? this.isTimerStart,
      breaks: breaks ?? this.breaks
    );
  }

  @override
  List<Object?> get props => [status, breakBack,isTimerStart,breaks];
}
