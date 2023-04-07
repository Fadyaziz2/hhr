import 'package:club_application/page/profile/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/src/models/contact_search.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:club_application/page/profile/profile.dart';
import '';

class ContactTile extends StatelessWidget {

  final ContactsSearch contact;

  const ContactTile({Key? key,required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(ProfileScreen.route(contact.id));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ListTile(
          title: Text(contact.name ?? ""),
          subtitle: Text(contact.bloodGroup ?? ""),
          // leading: Image.network(contact.avatar??'',scale: 2,),
          trailing: InkWell(
            onTap: () =>launchUrl(Uri.parse("tel://${contact.phone}")),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.phone,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
