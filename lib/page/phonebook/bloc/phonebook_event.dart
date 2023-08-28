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

class PhonebookSearchData extends PhonebookEvent {
  final String? searchText;

  PhonebookSearchData({this.searchText});

  @override
  List<Object?> get props => [searchText];
}

class PhonebookLoadRefresh extends PhonebookEvent {

  PhonebookLoadRefresh();

  @override
  List<Object?> get props => [];
}

class PhonebookLoadMore extends PhonebookEvent {

  PhonebookLoadMore();

  @override
  List<Object?> get props => [];
}
