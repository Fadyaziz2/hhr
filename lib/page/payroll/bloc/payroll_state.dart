part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final NetworkStatus status;
  final String? year;
  final PayrollModel? payroll;
  final bool? isLoading;

  const PayrollState(
      {required this.status, this.year, this.payroll, this.isLoading = true});

  PayrollState copyWith(
      {NetworkStatus? status,
      String? year,
      PayrollModel? payroll,
      bool? isLoading}) {
    return PayrollState(
        status: status ?? this.status,
        year: year ?? this.year,
        payroll: payroll ?? this.payroll,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [status, year, payroll, isLoading];
}
