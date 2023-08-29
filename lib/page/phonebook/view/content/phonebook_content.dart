import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_user_list.dart';

import '../../bloc/phonebook_bloc.dart';

class PhonebookContent extends StatelessWidget {
  const PhonebookContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValue = list.first;
    return Column(
      children: [
        PhonebookSearch(
          bloc: context.read<PhonebookBloc>(),
        ),
        Row(
          children: [
            Expanded(
              child:
                  DepartmentDropDown(dropdownValue: dropdownValue, list: list),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 16, left: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25)),
                child: DropdownButton<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 18,
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    // setState(() {
                    // dropdownValue = value!;
                    // });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const Expanded(child: PhonebookUserList())
      ],
      // children: [PhonebookUserList()],
    );
    // return BlocBuilder<PhonebookBloc, PhonebookState>(
    //   buildWhen: (cState,oState) => cState != oState,
    //     builder: (context, state) {
    //   if (state.status == NetworkStatus.loading) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }
    //   if (state.status == NetworkStatus.success) {
    //     if (state.phonebook != null) {
    //       return Column(
    //         children: [
    //           PhonebookSearch(
    //             bloc: context.read<PhonebookBloc>(),
    //           ),
    //           const Expanded(child: PhonebookUserList())
    //         ],
    //         // children: [PhonebookUserList()],
    //       );
    //     }
    //   }
    //   if (state.status == NetworkStatus.failure) {
    //     return const Center(
    //       child: Text('Failed to load phonebook'),
    //     );
    //   }
    //   return const SizedBox();
    // });
  }
}

class DepartmentDropDown extends StatelessWidget {
  const DepartmentDropDown({
    super.key,
    required this.dropdownValue,
    required this.list,
  });

  final String dropdownValue;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25)),
      child: DropdownButton<String>(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_drop_down_outlined,
          size: 18,
        ),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          // setState(() {
          // dropdownValue = value!;
          // });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
