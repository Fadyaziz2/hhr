import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/page/phonebook/view/content/filter_popup_menu/popup_menus_filter_content.dart';

class FilterBottomSheetList extends StatelessWidget {
  const FilterBottomSheetList({
    super.key,
    required this.settings,
    required this.controller,
    required this.type,
    this.bloc,
  });

  final Bloc? bloc;
  final Settings settings;
  final ScrollController controller;
  final PhonebookFilterType type;

  @override
  Widget build(BuildContext context) {
    return type.name == PhonebookFilterType.department.name
        ? buildDepartmentList(bloc)
        : buildDesignationList(bloc);
  }

  ListView buildDesignationList(Bloc? bloc) {
    return ListView.builder(
      controller: controller,
      itemCount: settings.data?.designations.length ?? 0,
      itemBuilder: (context, index) {
        final data = settings.data?.designations[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          tileColor:
          index % 2 == 0 ? Colors.grey.shade200 : Colors.grey.shade100,
          onTap: () {
            bloc?.add(SelectDesignationValue(data!));
            Navigator.pop(context);
          },
          title: Text(data?.title ?? '',style: TextStyle(fontSize: 12.r),),
        );
      },
    );
  }

  ListView buildDepartmentList(Bloc? bloc) {
    return ListView.builder(
      controller: controller,
      itemCount: settings.data?.departments.length ?? 0,
      itemBuilder: (context, index) {
        final data = settings.data?.departments[index];
        return ListTile(
          tileColor:
              index % 2 == 0 ? Colors.grey.shade200 : Colors.grey.shade100,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          onTap: () {
            bloc?.add(SelectDepartmentValue(data!));
            Navigator.pop(context);
          },
          title: Text(data?.title ?? '', style: TextStyle(fontSize: 12.r),),
        );
      },
    );
  }
}
