part of 'phonebook_bloc.dart';

class PhonebookState extends Equatable {
  final Phonebook? phonebook;
  final String? searchKey;
  final NetworkStatus status;

  const PhonebookState(
      {this.phonebook, this.status = NetworkStatus.initial, this.searchKey});

  PhonebookState copyWith(
      {Phonebook? phonebook, String? searchKey, NetworkStatus? status}) {
    return PhonebookState(
        phonebook: phonebook ?? this.phonebook,
        searchKey: searchKey ?? this.searchKey,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [phonebook, status, searchKey];
}
