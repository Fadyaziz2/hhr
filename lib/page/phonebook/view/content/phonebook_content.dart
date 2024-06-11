import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_search.dart';
import 'package:onesthrm/page/phonebook/view/content/phonebook_employees.dart';
import 'package:onesthrm/page/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

import '../../bloc/phonebook_bloc.dart';

class PhoneBookContent extends StatelessWidget {


  const PhoneBookContent({super.key});

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
              bloc: context.read<PhoneBookBloc>(),
            )
          ],
        ),
        const Expanded(child: PhoneBookEmployees())
      ],
    );
  }
}
