part of 'phonebook_bloc.dart';

class PhonebookState extends Equatable {
  final Phonebook? phonebook;
  final String? searchKey;
  final NetworkStatus status;
  final int pageCount;
  final PullStatus refreshStatus;

  const PhonebookState({
      this.phonebook,
      this.status = NetworkStatus.initial,
      this.refreshStatus = PullStatus.idle,
      this.searchKey,
      this.pageCount = 1});

  PhonebookState copyWith(
      {Phonebook? phonebook,
      String? searchKey,
      NetworkStatus? status,
      PullStatus? pullStatus,
      int? pageCount}) {
    return PhonebookState(
        phonebook: phonebook ?? this.phonebook,
        searchKey: searchKey ?? this.searchKey,
        status: status ?? this.status,
        refreshStatus: pullStatus ?? refreshStatus,
        pageCount: pageCount ?? this.pageCount);
  }

  @override
  List<Object?> get props => [phonebook, status, searchKey, refreshStatus];
}
