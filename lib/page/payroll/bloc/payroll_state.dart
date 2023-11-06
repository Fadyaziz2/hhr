part of 'payroll_bloc.dart';

class PayrollState extends Equatable {
  final NetworkStatus status;
  final PayrollModel? payroll;
  final bool? isLoading;

  const PayrollState(
      {required this.status,this.payroll, this.isLoading = true});

  PayrollState copyWith(
      {NetworkStatus? status,
      String? year,
      PayrollModel? payroll,
      bool? isLoading}) {
    return PayrollState(
        status: status ?? this.status,
        payroll: payroll ?? this.payroll,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [status, payroll, isLoading];
}
