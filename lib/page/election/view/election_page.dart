import 'package:club_application/page/authentication/bloc/authentication_bloc.dart';
import 'package:club_application/page/election/view/content/election_content.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../bloc/election_bloc.dart';

class ElectionPage extends StatelessWidget {
  const ElectionPage({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (_) => const ElectionPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
    create: (_) => ElectionBloc(clubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(ElectionLoadRequest()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Election'),
          backgroundColor: mainColor,
        ),
        body: const ElectionContent(),
      ),
    );
  }
}
