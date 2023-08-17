import 'package:equatable/equatable.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSupportData extends SupportEvent {
  GetSupportData();

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends SupportEvent {
  SelectDatePicker();

  @override
  List<Object> get props => [];
}
