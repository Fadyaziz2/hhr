part of 'payroll_bloc.dart';

abstract class PayrollEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PayrollInitialDataRequest extends PayrollEvent {
  PayrollInitialDataRequest();

  @override
  List<Object?> get props => [];
}
