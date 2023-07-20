part of 'break_bloc.dart';

class BreakState extends Equatable {
  final NetworkStatus status;
  final Break? breakBack;
  final bool isTimerStart;

  const BreakState(
      {this.status = NetworkStatus.initial,
      this.breakBack,
      this.isTimerStart = false});

  BreakState copyWith({NetworkStatus? status, Break? breakBack, bool? isTimerStart}) {
    return BreakState(
      status: status ?? this.status,
      breakBack: breakBack ?? this.breakBack,
      isTimerStart: isTimerStart ?? this.isTimerStart,
    );
  }

  @override
  List<Object?> get props => [status, breakBack,isTimerStart];
}
