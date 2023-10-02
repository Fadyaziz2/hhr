part of 'appoinment_create_bloc.dart';

class AppoinmentCreatState extends Equatable {
  final NetworkStatus status;

  final String? currentMonth;
  final String? startTime;
  final String? endTime;

  const AppoinmentCreatState(
      {this.status = NetworkStatus.initial,
      this.currentMonth,
      this.startTime,
      this.endTime});

  AppoinmentCreatState copyWith({
    NetworkStatus? status,
    String? currentMonth,
    final String? startTime,
    final String? endTime,
  }) {
    return AppoinmentCreatState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }

  @override
  List<Object?> get props => [status, currentMonth, startTime, endTime];
}
