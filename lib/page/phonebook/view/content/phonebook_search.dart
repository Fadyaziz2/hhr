import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/phonebook.dart';

import '../../../../res/common/debouncer.dart';

class PhoneBookSearch extends StatelessWidget {
  const PhoneBookSearch({Key? key, this.bloc}) : super(key: key);
  final Bloc? bloc;

  @override
  Widget build(BuildContext context) {
    final deBouncer = Debounce(milliseconds: 1000);
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 8.0, top: 10, bottom: 10.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "search".tr(),
          filled: true,
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
        ),
        onChanged: (value) {
          deBouncer.run(() =>
              bloc?.add(PhoneBookSearchData(searchText: value.toString())));
        },
      ),
    );
  }
}
