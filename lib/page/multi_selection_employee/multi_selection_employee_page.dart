import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/multi_selection_employee/content/get_multi_employee_content.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../authentication/bloc/authentication_bloc.dart';

class MultiSelectionEmployee extends StatelessWidget {
  const MultiSelectionEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (_) => PhoneBookBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(PhoneBookLoadRequest()),
      child: Scaffold(
          appBar:AppBar(
                title: const Text("Multi Selection Employee"),
                leading: BlocBuilder<PhoneBookBloc,PhoneBookState> (
                builder: (context,state) {
                  return state.isMultiSelectionEnabled
                      ? IconButton(
                      onPressed: () {
                        // selectedItem.clear(); // todo need to clear selected list
                        context.read<PhoneBookBloc>().add(IsMultiSelectionEnabled(false));
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ))
                      : IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ));
                })),
          body: const GetMultiEmployeeContent()),
    );
  }
}
