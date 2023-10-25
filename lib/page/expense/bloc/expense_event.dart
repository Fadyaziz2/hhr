part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetExpenseData extends ExpenseEvent {
  final String? date;
  final String? paymentId;
  final String? statusTypeId;
  final String? paymentTypeName;
  final String? statusTypeName;

  GetExpenseData(
      {this.date,
      this.statusTypeId,
      this.paymentId,
      this.paymentTypeName,
      this.statusTypeName});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends ExpenseEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class SelectPaymentType extends ExpenseEvent {
  final String? paymentType;
  final BuildContext context;
  SelectPaymentType(this.context, this.paymentType);

  @override
  List<Object> get props => [
        context,
      ];
}

class SelectStatus extends ExpenseEvent {
  final String? statusType;
  final BuildContext context;
  SelectStatus(this.context, this.statusType);

  @override
  List<Object> get props => [context];
}
