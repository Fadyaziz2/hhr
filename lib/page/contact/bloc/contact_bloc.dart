import 'package:club_application/page/contact/models/search_formz.dart';
import 'package:equatable/equatable.dart';
import '../../../res/enum.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/src/models/contact_search.dart';
part 'contact_event.dart';
part 'contact_state.dart';


class ContactBloc extends Bloc<ContactEvent,ContactState>{

  final MetaClubApiClient metaClubApiClient;

  ContactBloc({required this.metaClubApiClient}):super(const ContactState(status: NetworkStatus.initial)){
    on<ContactLoadRequest>(_onContactLoadRequest);
    on<OnSearchChanged>(_onContactFilterRequest);
  }

  void _onContactFilterRequest(OnSearchChanged event,Emitter<ContactState> emit){

    emit(const ContactState(status: NetworkStatus.loading));

    try{

      final search = SearchContact.dirty(event.search);

      final filteredList = event.contacts.where((contact) => contact.name != null ? contact.name!.toLowerCase().startsWith(search.value.toLowerCase()):false).toList();

      emit(ContactState(filterContacts: filteredList ,status: NetworkStatus.success,contacts: ContactsSearchList(contactList: event.contacts)));


    }catch(_){
      emit(const ContactState(status: NetworkStatus.failure));
    }
  }

  void _onContactLoadRequest(ContactLoadRequest event,Emitter<ContactState> emit) async {
    emit(const ContactState(status: NetworkStatus.loading));
    try{
      final contacts = await metaClubApiClient.contactsSearchList();
      emit(ContactState(status: NetworkStatus.success,contacts: contacts != null ? contacts :  ContactsSearchList(contactList: [])));
    }catch(_){
      emit(const ContactState(status: NetworkStatus.failure));
      throw ContactRequestFailure();
    }
  }
}
