import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_user_list.dart';
import 'package:onesthrm/res/enum.dart';

import '../../bloc/phonebook_bloc.dart';

class PhonebookContent extends StatelessWidget {
  const PhonebookContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhonebookSearch(
          bloc: context.read<PhonebookBloc>(),
        ),
        const Expanded(child: PhonebookUserList())
      ],
      // children: [PhonebookUserList()],
    );
    return BlocBuilder<PhonebookBloc, PhonebookState>(
      buildWhen: (cState,oState) => cState != oState,
        builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        if (state.phonebook != null) {
          return Column(
            children: [
              PhonebookSearch(
                bloc: context.read<PhonebookBloc>(),
              ),
              const Expanded(child: PhonebookUserList())
            ],
            // children: [PhonebookUserList()],
          );
        }
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Failed to load phonebook'),
        );
      }
      return const SizedBox();
    });
  }
}
