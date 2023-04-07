import 'package:club_application/page/anniversary/bloc/anniversary_bloc.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import 'content/anniversary_content.dart';

class AnniversaryPage extends StatelessWidget {
  const AnniversaryPage({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const AnniversaryPage());


  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(create: (BuildContext context) => AnniversaryBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(AnniversaryLoadRequest()),
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Anniversary'),
        backgroundColor: mainColor,
      ),
      body: const AnniversaryContent(),
    ));
  }
}

