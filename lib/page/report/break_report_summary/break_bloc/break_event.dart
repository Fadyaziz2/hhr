part of 'break_bloc.dart';

abstract class BreakEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBreakInitialData extends BreakEvent {
  GetBreakInitialData();

  @override
  List<Object> get props => [];
}

class SelectDate extends BreakEvent {
  final BuildContext context;
  final bool isEmployeeScreen;
  SelectDate(this.context, this.isEmployeeScreen);

  @override
  List<Object> get props => [isEmployeeScreen];
}

class SelectEmployee extends BreakEvent {
  final PhoneBookUser selectEmployee;

  SelectEmployee(this.selectEmployee);

  @override
  List<Object> get props => [selectEmployee];
}
