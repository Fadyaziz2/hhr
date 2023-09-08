part of 'appoinment_bloc.dart';

abstract class AppoinmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAppoinmentData extends AppoinmentEvent {
  final String? date;

  GetAppoinmentData({this.date});

  @override
  List<Object> get props => [];
}

class SelectDatePicker extends AppoinmentEvent {
  final BuildContext context;
  SelectDatePicker(this.context);

  @override
  List<Object> get props => [context];
}
