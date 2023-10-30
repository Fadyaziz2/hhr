part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  final NetworkStatus? status;
  final String? currentMonth;
  final String? paymentId;
  final String? statusType;
  final String? statusTypeName;
  final String? paymentTypeName;
  final String? selectedCategoryId;
  final ResponseExpenseList? responseExpenseList;
  final ExpenseCategoryModel? expenseCategoryData;

  const ExpenseState(
      {this.status,
      this.currentMonth,
      this.responseExpenseList,
      this.paymentId,
      this.paymentTypeName,
      this.statusTypeName,
      this.expenseCategoryData,
      this.selectedCategoryId,
      this.statusType});

  ExpenseState copy({
    NetworkStatus? status,
    String? paymentId,
    String? currentMonth,
    ResponseExpenseList? responseExpenseList,
    String? paymentTypeName,
    String? paymentType,
    String? statusTypeName,
    String? statusType,
    String? selectedCategoryId,
    ExpenseCategoryModel? expenseCategoryData,
  }) {
    return ExpenseState(
        status: status ?? this.status,
        currentMonth: currentMonth ?? this.currentMonth,
        responseExpenseList: responseExpenseList ?? this.responseExpenseList,
        paymentId: paymentId ?? this.paymentId,
        paymentTypeName: paymentTypeName ?? this.paymentTypeName,
        statusTypeName: statusTypeName ?? this.statusTypeName,
        expenseCategoryData: expenseCategoryData ?? this.expenseCategoryData,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        statusType: statusType ?? this.statusType);
  }

  @override
  List<Object?> get props => [
        status,
        currentMonth,
        responseExpenseList,
        statusType,
        paymentId,
        paymentTypeName,
        statusTypeName,
        expenseCategoryData,
        selectedCategoryId,
      ];
}
