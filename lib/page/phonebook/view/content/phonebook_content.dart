import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_employees.dart';
import 'package:onesthrm/page/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

import '../../bloc/phonebook_bloc.dart';

class PhonebookContent extends StatelessWidget {
  final Settings settings;

  const PhonebookContent({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PhonebookSearch(
                bloc: context.read<PhonebookBloc>(),
              ),
            ),
            PopupMenusFilerContent(
              settings: settings,
              bloc: context.read<PhonebookBloc>(),
            )
          ],
        ),
        const Expanded(child: PhonebookEmployees())
      ],
    );
  }
}
