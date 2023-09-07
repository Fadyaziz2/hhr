import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_user_list.dart';

import '../../bloc/phonebook_bloc.dart';
import 'department_dropdown.dart';
import 'designation_dropdown.dart';

enum PhonebookFilterType { Designation, Department }

class PhonebookContent extends StatelessWidget {
  final Settings settings;

  const PhonebookContent({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhonebookFilterType? selectedMenu;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PhonebookSearch(
                bloc: context.read<PhonebookBloc>(),
              ),
            ),
            PopupMenuButton<PhonebookFilterType>(
              icon: const Icon(Icons.filter_alt),
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (PhonebookFilterType item) {
                // setState(() {
                //   selectedMenu = item;
                // });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PhonebookFilterType>>[
                PopupMenuItem<PhonebookFilterType>(
                  value: PhonebookFilterType.Designation,
                  child: const Text('Department'),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.share),
                                title: Text('Share'),
                              ),
                              ListTile(
                                leading: Icon(Icons.copy),
                                title: Text('Copy Link'),
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ],
                          );
                        });
                  },
                ),
                const PopupMenuItem<PhonebookFilterType>(
                  value: PhonebookFilterType.Department,
                  child: Text('Designation'),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DepartmentDropDown(
                settings: settings,
              ),
            ),
            Expanded(
              child: DesignationDropdown(
                settings: settings,
              ),
            ),
          ],
        ),
        const Expanded(child: PhonebookUserList())
      ],
      // children: [PhonebookUserList()],
    );
  }
}
