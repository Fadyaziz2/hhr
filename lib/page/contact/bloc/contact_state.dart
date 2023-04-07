part of 'contact_bloc.dart';


class ContactState extends Equatable {
  final ContactsSearchList? contacts;
  final List<ContactsSearch> filterContacts;
  final NetworkStatus status;


  const ContactState({this.contacts, this.status = NetworkStatus.initial,this.filterContacts = const []});

  ContactState copyWith({required ContactsSearchList? contacts, required NetworkStatus? status}) {
    return ContactState(contacts: contacts ?? this.contacts, status: status ?? this.status);
  }


  @override
  List<Object?> get props => [contacts, status];
}
