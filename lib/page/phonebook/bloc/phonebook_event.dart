part of 'phonebook_bloc.dart';

abstract class PhonebookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhonebookLoadRequest extends PhonebookEvent {
  PhonebookLoadRequest();

  @override
  List<Object?> get props => [];
}
