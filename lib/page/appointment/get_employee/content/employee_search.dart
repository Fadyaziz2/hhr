import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/phonebook/bloc/phonebook_bloc.dart';
import 'package:onesthrm/res/common/debouncer.dart';

class EmployeeSearch extends StatelessWidget {
  final Bloc? bloc;
  const EmployeeSearch({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    final deBouncer = Debounce(milliseconds: 1000);

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 8.0, top: 10, bottom: 10.0),
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
        onChanged: (value) {
          deBouncer.run(() =>
              bloc?.add(PhonebookSearchData(searchText: value.toString())));
        },
      ),
    );
  }
}
