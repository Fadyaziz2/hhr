import 'package:club_application/page/donation/bloc/donation_bloc.dart';
import 'package:club_application/res/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import 'content/donation_content.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (_) => const DonationPage());

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (BuildContext context) => DonationBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.token}'))
        ..add(DonationLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Donation'),
          backgroundColor: mainColor,
        ),
        body: const DonationContent(),
      ),
    );
  }
}
