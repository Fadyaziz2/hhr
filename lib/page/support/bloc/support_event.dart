part of 'support_bloc.dart';

abstract class SupportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSupportData extends SupportEvent {

  final Filter filter;
  final String? date;

  GetSupportData({this.filter = Filter.open,this.date});

  @override
  List<Object> get props => [filter];
}

class SelectDatePicker extends SupportEvent {
 final  BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}

class OnFilterUpdate extends SupportEvent {
  final Filter filter;
  final String? date;
  OnFilterUpdate({this.filter = Filter.open,this.date});

  @override
  List<Object> get props => [filter];
}
