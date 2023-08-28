import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_content.dart';
import 'package:onesthrm/res/const.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhonebookListPage extends StatelessWidget {
  const PhonebookListPage({Key? key}) : super(key: key);

  static Route route(int? userId, Settings? settings) =>
      MaterialPageRoute(builder: (_) => const PhonebookListPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
        create: (_) => PhonebookBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(PhonebookLoadRequest()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Phonebook'),
            backgroundColor: mainColor,
          ),
          body: const PhonebookContent(),
        ));
  }
}
