import 'package:club_application/page/birthday/bloc/birthday_bloc.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'content/birthday_content.dart';

class BirthdayPage extends StatelessWidget {

  const BirthdayPage({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const BirthdayPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (BuildContext context) => BirthdayBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(BirthdayLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Birthday'),
          backgroundColor: mainColor,
        ),
        body: const BirthdayContent(),
      ),
    );
  }
}
