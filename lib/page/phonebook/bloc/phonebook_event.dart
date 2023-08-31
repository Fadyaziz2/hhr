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

class SelectDepartmentValue extends PhonebookEvent {
  final Department departmentsData;

  SelectDepartmentValue(this.departmentsData);

  @override
  List<Object?> get props => [departmentsData];
}

class SelectDesignationValue extends PhonebookEvent {
  final Department designationData;

  SelectDesignationValue(this.designationData);

  @override
  List<Object?> get props => [designationData];
}

class DirectPhoneCall extends PhonebookEvent {
  final String phoneNumber;

  DirectPhoneCall(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PhonebookDetails extends PhonebookEvent {
  final String userId;

  PhonebookDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}
