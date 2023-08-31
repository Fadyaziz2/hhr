import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';

class DepartmentDropDown extends StatelessWidget {
  final Settings settings;

  const DepartmentDropDown({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhonebookBloc, PhonebookState>(
      builder: (BuildContext context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 16, right: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25)),
          child: DropdownButton<Department>(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            hint: const Text('Select Department'),
            isExpanded: true,
            value: state.departments,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 0,
            ),
            onChanged: (Department? value) {
              context.read<PhonebookBloc>().add(SelectDepartmentValue(value!));
            },
            items: settings.data?.departments
                .map<DropdownMenuItem<Department>>((Department value) {
              return DropdownMenuItem<Department>(
                value: value,
                child: Text(value.title ?? ''),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
