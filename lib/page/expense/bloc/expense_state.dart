part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;

  const ExpenseState({
    this.status,
    this.currentMonth,
  });

  ExpenseState copy({
    NetworkStatus? status,
    String? currentMonth,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
      ];
}
