part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpenseData extends ExpenseEvent {
  final String? date;

  GetExpenseData({this.date});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends ExpenseEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}
