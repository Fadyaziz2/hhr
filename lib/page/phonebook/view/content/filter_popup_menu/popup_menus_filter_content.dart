import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/filter_popup_menu/filter_bottom_sheet_list.dart';

enum PhonebookFilterType { designation, department }

class PopupMenusFilerContent extends StatelessWidget {
  final Settings settings;
  final Bloc? bloc;

  const PopupMenusFilerContent({
    super.key,
    required this.settings,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    PhonebookFilterType? selectedMenu;
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
      child: PopupMenuButton<PhonebookFilterType>(
        icon: const Icon(Icons.filter_alt_outlined),
        initialValue: selectedMenu,
        onSelected: (PhonebookFilterType item) {
          _onChoiceSelectedModelSheet(
            context,
            item,
            bloc,
          );
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<PhonebookFilterType>>[
          const PopupMenuItem<PhonebookFilterType>(
            value: PhonebookFilterType.department,
            child: Text('Department'),
          ),
          const PopupMenuItem<PhonebookFilterType>(
            value: PhonebookFilterType.designation,
            child: Text('Designation'),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _onChoiceSelectedModelSheet(
      context, PhonebookFilterType item, Bloc? bloc) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.2,
        maxChildSize: 0.85,
        expand: false,
        builder: (_, controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[600],
                ),
              ),
            ),
            ListTile(
              title: Text(
                item.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: FilterBottomSheetList(
                bloc: bloc,
                settings: settings,
                controller: controller,
                type: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
