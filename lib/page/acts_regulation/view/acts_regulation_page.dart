import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/acts_regulation_bloc.dart';
import 'contents/acts_regulation_content.dart';

class ActsRegulationPage extends StatelessWidget {
  const ActsRegulationPage({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const ActsRegulationPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (BuildContext context) => ActsRegulationBloc(
            clubApiClient: MetaClubApiClient(token: '${user?.token}'))..add(ActsRequestLoadRequest()),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Acts & Regulations'),
              backgroundColor: mainColor,
            ),
            body: const ActsRegulationContent())
    );
  }
}
