import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_content.dart';
import 'package:onesthrm/res/const.dart';

class PhoneBookPage extends StatelessWidget {
  final Settings? settings;
  const PhoneBookPage({super.key, this.settings});

  static Route route(int? userId, Settings? settings) =>
      MaterialPageRoute(builder: (_) => PhoneBookPage(settings: settings!));

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
        create: (_) => PhoneBookBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(PhoneBookLoadRequest()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('PhoneBook'),
            backgroundColor: mainColor,
          ),
          body: PhoneBookContent(
            settings: settings!,
          ),
        ));
  }
}
