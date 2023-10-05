part of 'phonebook_bloc.dart';

class PhonebookState extends Equatable {
  final List<PhoneBookUser>? phonebookUsers;
  final String? searchKey;
  final NetworkStatus status;
  final int pageCount;
  final PullStatus refreshStatus;
  final Department? departments;
  final Department? designations;
  final PhonebookDetailsModel? phonebookDetails;

  const PhonebookState(
      {this.phonebookUsers,
      this.status = NetworkStatus.initial,
      this.refreshStatus = PullStatus.idle,
      this.searchKey,
      this.pageCount = 1,
      this.departments,
      this.designations,
      this.phonebookDetails});

  PhonebookState copyWith(
      {List<PhoneBookUser>? phonebookUsers,
      String? searchKey,
      NetworkStatus? status,
      PullStatus? pullStatus,
      int? pageCount,
      Department? departments,
      Department? designations,
      PhonebookDetailsModel? phonebookDetails}) {
    return PhonebookState(
        phonebookUsers: phonebookUsers ?? this.phonebookUsers,
        searchKey: searchKey ?? this.searchKey,
        status: status ?? this.status,
        refreshStatus: pullStatus ?? refreshStatus,
        pageCount: pageCount ?? this.pageCount,
        departments: departments ?? this.departments,
        designations: designations ?? this.designations,
        phonebookDetails: phonebookDetails ?? this.phonebookDetails);
  }

  @override
  List<Object?> get props => [
        phonebookUsers,
        status,
        searchKey,
        refreshStatus,
        departments,
        designations,
        phonebookDetails
      ];
}
