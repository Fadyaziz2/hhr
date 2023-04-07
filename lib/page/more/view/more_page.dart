import 'package:club_application/page/birthday/bloc/birthday_bloc.dart';
import 'package:club_application/page/more/more.dart';
import 'package:club_application/page/more/view/content/more_page_content.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(builder: (_) => const MorePage());

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (BuildContext context) => MoreBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))
          ..add(ContentLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('More'),
          backgroundColor: mainColor,
        ),
        body: const MoreContent(),
      ),
    );
  }
}
