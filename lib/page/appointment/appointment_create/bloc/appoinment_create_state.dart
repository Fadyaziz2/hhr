part of 'appoinment_create_bloc.dart';

class AppoinmentCreatState extends Equatable {
  final NetworkStatus status;

  final String? currentMonth;
  final String? startTime;
  final String? endTime;
  final PhonebookUser? selectedEmployee;

  const AppoinmentCreatState(
      {this.status = NetworkStatus.initial,
      this.currentMonth,
      this.startTime,
      this.selectedEmployee,
      this.endTime});

  AppoinmentCreatState copyWith({
    NetworkStatus? status,
    String? currentMonth,
    final String? startTime,
    final String? endTime,
    final String? employeeName,
    final PhonebookUser? selectedEmployee,
  }) {
    return AppoinmentCreatState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        selectedEmployee: selectedEmployee ?? this.selectedEmployee);
  }

  @override
  List<Object?> get props =>
      [status, currentMonth, startTime, endTime, selectedEmployee];
}
