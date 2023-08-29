part of 'phonebook_bloc.dart';

class PhonebookState extends Equatable {
  // final Phonebook? phonebook;
  final List<PhonebookUser>? phonebookUsers;
  final List<DepartmentsData>? listOfDepartments;
  final String? searchKey;
  final NetworkStatus status;
  final int pageCount;
  final PullStatus refreshStatus;

  const PhonebookState(
      {this.listOfDepartments,
      this.phonebookUsers,
      this.status = NetworkStatus.initial,
      this.refreshStatus = PullStatus.idle,
      this.searchKey,
      this.pageCount = 1});

  PhonebookState copyWith(
      {List<PhonebookUser>? phonebookUsers,
      List<DepartmentsData>? listOfDepartments,
      String? searchKey,
      NetworkStatus? status,
      PullStatus? pullStatus,
      int? pageCount}) {
    return PhonebookState(
        phonebookUsers: phonebookUsers ?? this.phonebookUsers,
        listOfDepartments: listOfDepartments ?? this.listOfDepartments,
        searchKey: searchKey ?? this.searchKey,
        status: status ?? this.status,
        refreshStatus: pullStatus ?? refreshStatus,
        pageCount: pageCount ?? this.pageCount);
  }

  @override
  List<Object?> get props => [phonebookUsers, status, searchKey, refreshStatus, listOfDepartments];
}
