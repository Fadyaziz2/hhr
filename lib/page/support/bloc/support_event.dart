import 'package:equatable/equatable.dart';
import 'package:onesthrm/res/enum.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSupportData extends SupportEvent {

  final Filter filter;

  GetSupportData({this.filter = Filter.open});

  @override
  List<Object> get props => [filter];
}

class SelectDatePicker extends SupportEvent {
  SelectDatePicker();

  @override
  List<Object> get props => [];
}

class OnFilterUpdate extends SupportEvent {
  final Filter filter;
  OnFilterUpdate({this.filter = Filter.open});

  @override
  List<Object> get props => [filter];
}
