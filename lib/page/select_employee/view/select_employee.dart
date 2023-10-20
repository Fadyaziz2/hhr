import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/select_employee/content/get_employee_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/res/const.dart';

class SelectEmployeePage extends StatelessWidget {
  const SelectEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (_) => PhoneBookBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(PhoneBookLoadRequest()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Employee'),
          backgroundColor: mainColor,
        ),
        body: const GetEmployeeContent(),
      ),
    );
  }
}
