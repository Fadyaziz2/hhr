import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_user_list.dart';

import '../../bloc/phonebook_bloc.dart';
import 'department_dropdown.dart';
import 'designation_dropdown.dart';

class PhonebookContent extends StatelessWidget {
  final Settings settings;
  const PhonebookContent({Key? key,required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhonebookSearch(
          bloc: context.read<PhonebookBloc>(),
        ),
        Row(
          children: [
             Expanded(
              child: DepartmentDropDown(settings: settings,),
            ),
            Expanded(
              child: DesignationDropdown(settings: settings,),
            ),
          ],
        ),
        const Expanded(child: PhonebookUserList())
      ],
      // children: [PhonebookUserList()],
    );
  }
}
