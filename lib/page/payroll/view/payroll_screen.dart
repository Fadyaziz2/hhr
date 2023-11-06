import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/payroll/bloc/payroll_bloc.dart';
import 'package:onesthrm/page/payroll/view/content/payroll_screen_content.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (_) => PayrollBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(PayrollInitialDataRequest()),
      child: const PayrollScreenContent(),
      );
  }
}
