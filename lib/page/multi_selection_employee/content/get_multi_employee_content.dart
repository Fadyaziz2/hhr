import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/multi_selection_employee/content/multi_select_employee_list.dart';

import '../../phonebook/bloc/phonebook_bloc.dart';
import '../../select_employee/content/employee_search.dart';

class GetMultiEmployeeContent extends StatelessWidget {
  const GetMultiEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmployeeSearch(
          bloc: context.read<PhoneBookBloc>(),
        ),
        Text(
          "** Please, long press to select employee **",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.green),
        ),
        const Expanded(child: MultiSelectEmployeeList()),
      ],
    );
  }
}
