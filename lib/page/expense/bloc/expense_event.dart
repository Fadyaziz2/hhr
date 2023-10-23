part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpenseData extends ExpenseEvent {
  final String? date;
  final String? paymentType;
  final String? status;

  GetExpenseData({this.date, this.paymentType, this.status});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends ExpenseEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}
