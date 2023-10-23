part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final String? paymentType;
  final String? statusType;
  final ResponseExpenseList? responseExpenseList;

  const ExpenseState(
      {this.status,
      this.currentMonth,
      this.responseExpenseList,
      this.paymentType,
      this.statusType});

  ExpenseState copy({
    NetworkStatus? status,
    String? currentMonth,
    ResponseExpenseList? responseExpenseList,
    String? paymentType,
    String? statusType,
  }) {
    return ExpenseState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        responseExpenseList: responseExpenseList ?? this.responseExpenseList,
        paymentType: paymentType ?? this.paymentType,
        statusType: statusType ?? this.statusType);
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        responseExpenseList,
        paymentType,
        statusType,
      ];
}
