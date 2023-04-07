import 'package:club_application/page/contact/bloc/contact_bloc.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import '../../../../res/const.dart';
import 'contact_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactContent extends StatelessWidget {

  const ContactContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc,ContactState>(
      builder: (context,state){
        if(state.status == NetworkStatus.loading){
          return Center(child: CircularProgressIndicator(color: mainColor));
        }
        if(state.status == NetworkStatus.success) {
          if(state.contacts != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      filled: true,
                      contentPadding: EdgeInsets.all(0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    onChanged: (value) => context.read<ContactBloc>().add(OnSearchChanged(search: value,contacts: state.contacts != null ? state.contacts!.contactList : [])),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.filterContacts.isEmpty ? state.contacts?.contactList.length ?? 0 : state.filterContacts.length,
                    itemBuilder: (context, index) {

                      final contact = state.filterContacts.isEmpty ? state.contacts!.contactList.elementAt(index) : state.filterContacts.elementAt(index);

                      return ContactTile(contact: contact);
                    },
                  ),
                ),
              ],
            );
          }
        }
        if (state.status == NetworkStatus.failure) {
          return const Center(
            child: Text('Error to load'),
          );
        }
        return const SizedBox();
      },
    );
  }
}
