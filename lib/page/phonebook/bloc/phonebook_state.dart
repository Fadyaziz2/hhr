part of 'phonebook_bloc.dart';

class PhoneBookState extends Equatable {
  final List<PhoneBookUser>? phoneBookUsers;
  final String? searchKey;
  final NetworkStatus status;
  final int pageCount;
  final PullStatus refreshStatus;
  final Department? departments;
  final Department? designations;
  final PhoneBookDetailsModel? phoneBookDetails;

  const PhoneBookState(
      {this.phoneBookUsers,
      this.status = NetworkStatus.initial,
      this.refreshStatus = PullStatus.idle,
      this.searchKey,
      this.pageCount = 1,
      this.departments,
      this.designations,
      this.phoneBookDetails});

  PhoneBookState copyWith(
      {List<PhoneBookUser>? phoneBookUsers,
      String? searchKey,
      NetworkStatus? status,
      PullStatus? pullStatus,
      int? pageCount,
      Department? departments,
      Department? designations,
      PhoneBookDetailsModel? phoneBookDetails}) {
    return PhoneBookState(
        phoneBookUsers: phoneBookUsers ?? this.phoneBookUsers,
        searchKey: searchKey ?? this.searchKey,
        status: status ?? this.status,
        refreshStatus: pullStatus ?? refreshStatus,
        pageCount: pageCount ?? this.pageCount,
        departments: departments ?? this.departments,
        designations: designations ?? this.designations,
        phoneBookDetails: phoneBookDetails ?? this.phoneBookDetails);
  }

  @override
  List<Object?> get props => [
        phoneBookUsers,
        status,
        searchKey,
        refreshStatus,
        departments,
        designations,
        phoneBookDetails
      ];
}
