import 'package:club_application/page/contact/bloc/contact_bloc.dart';
import 'package:club_application/page/contact/contact.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (_) => const ContactPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) => ContactBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))
        ..add(ContactLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          backgroundColor: mainColor,
        ),
        body: const ContactContent(),
      ),
    );
  }
}
