part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class OnSearchChanged extends ContactEvent{
  final String search;
  final List<ContactsSearch> contacts;
  OnSearchChanged({required this.search, this.contacts = const []});
  @override
  List<Object?> get props => [search,contacts];
}

class ContactLoadRequest extends ContactEvent{}