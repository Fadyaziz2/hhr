import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/phonebook.dart';

import '../../../../res/common/debouncer.dart';

class PhonebookSearch extends StatelessWidget {
  const PhonebookSearch({Key? key, this.bloc}) : super(key: key);
  final Bloc? bloc;

  @override
  Widget build(BuildContext context) {
    final _debouncer = Debouncer(milliseconds: 2000);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          filled: true,
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
        ),
        // controller: allUserProvider.searchUserData,
        onChanged: (value) {
          _debouncer.run(() =>
              bloc?.add(PhonebookSearchData(searchText: value.toString())));
        },
      ),
    );
  }
}
