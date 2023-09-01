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
  final int? pageCount;
  final int? departmentId;
  final int? designationId;

  PhonebookSearchData({this.searchText, this.pageCount = 1, this.departmentId, this.designationId});

  @override
  List<Object?> get props => [searchText, pageCount, departmentId, designationId];
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

class DirectMessage extends PhonebookEvent {
  final String phoneNumber;

  DirectMessage(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class DirectMailTo extends PhonebookEvent {
  final String email;
  final String userName;

  DirectMailTo(this.email, this.userName);

  @override
  List<Object?> get props => [email, userName];
}

class PhonebookDetails extends PhonebookEvent {
  final String userId;

  PhonebookDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}
