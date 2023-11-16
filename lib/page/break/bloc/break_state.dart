part of 'break_bloc.dart';

class BreakState extends Equatable {
  final NetworkStatus status;
  final Break? breakBack;
  final bool isTimerStart;
  final List<Break>? breaks;
  final String? currentDate;
  final BreakReportModel? breakReportModel;

  const BreakState({
    this.status = NetworkStatus.initial,
    this.breakBack,
    this.currentDate,
    this.isTimerStart = false,
    this.breaks,
    this.breakReportModel,
  });

  BreakState copyWith(
      {NetworkStatus? status,
      Break? breakBack,
      bool? isTimerStart,
      List<Break>? breaks,
      BreakReportModel? breakReportModel,
      String? currentDate}) {
    return BreakState(
        status: status ?? this.status,
        breakBack: breakBack ?? this.breakBack,
        isTimerStart: isTimerStart ?? this.isTimerStart,
        breaks: breaks ?? this.breaks,
        currentDate: currentDate ?? this.currentDate,
        breakReportModel: breakReportModel ?? this.breakReportModel);
  }

  @override
  List<Object?> get props =>
      [status, breakBack, isTimerStart, breaks, currentDate];
}
