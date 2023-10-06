import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/appointment/get_employee/content/employee_list.dart';
import 'package:onesthrm/page/appointment/get_employee/content/employee_search.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';

class GetEmployeeContent extends StatelessWidget {
  const GetEmployeeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmployeeSearch(
          bloc: context.read<PhoneBookBloc>(),
        ),
        const Expanded(child: EmployeeList()),
      ],
    );
  }
}
