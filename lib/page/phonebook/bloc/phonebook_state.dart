part of 'phonebook_bloc.dart';

class PhonebookState extends Equatable {
  final Phonebook? phonebook;
  final NetworkStatus status;

  const PhonebookState({this.phonebook, this.status = NetworkStatus.initial});

  PhonebookState copyWith({Phonebook? phonebook, NetworkStatus? status}) {
    return PhonebookState(
        phonebook: phonebook ?? this.phonebook, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [phonebook, status];
}
