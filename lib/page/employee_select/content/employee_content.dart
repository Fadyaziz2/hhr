import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/employee_select/content/select_employees.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

class EmployeeContent extends StatelessWidget {
  final Settings settings;

  const EmployeeContent({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PhoneBookSearch(
                bloc: context.read<PhoneBookBloc>(),
              ),
            ),
            PopupMenusFilerContent(
              settings: settings,
              bloc: context.read<PhoneBookBloc>(),
            )
          ],
        ),
        const Expanded(child: SelectEployees())
      ],
    );
  }
}
