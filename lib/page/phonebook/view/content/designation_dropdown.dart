import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';

class DesignationDropdown extends StatelessWidget {
  final Settings settings;

  const DesignationDropdown({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhonebookBloc, PhonebookState>(
      builder: (BuildContext context, state) {
        return Container(
          margin: const EdgeInsets.only(left: 8, right: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25)),
          child: DropdownButton<Department>(
            isDense: true,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            hint: const Text('Select Designation'),
            isExpanded: true,
            value: state.designations,
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
              context.read<PhonebookBloc>().add(SelectDesignationValue(value!));
            },
            items: settings.data?.designations
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
