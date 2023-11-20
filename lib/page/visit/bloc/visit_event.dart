part of 'visit_bloc.dart';

abstract class VisitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitListApi extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class VisitDetailsApi extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class HistoryListApi extends VisitEvent {
  @override
  List<Object?> get props => [];
}

class SelectDatePicker extends VisitEvent {
  final BuildContext context;

  SelectDatePicker(this.context);

  @override
  List<Object> get props => [];
}

class SelectMonthPicker extends VisitEvent {
  final BuildContext context;

  SelectMonthPicker(this.context);

  @override
  List<Object> get props => [];
}

class CreateVisitEvent extends VisitEvent {
  final BodyCreateVisit bodyCreateVisit;
  final BuildContext context;

  CreateVisitEvent(
      {required this.bodyCreateVisit,
      required this.context,
     });

  @override
  List<Object> get props => [bodyCreateVisit];
}
