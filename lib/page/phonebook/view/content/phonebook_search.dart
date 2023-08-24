import 'package:flutter/material.dart';

class PhonebookSearch extends StatelessWidget {
  const PhonebookSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: TextField(
        decoration:  InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "search",
          filled: true,
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
        ),
        // controller: allUserProvider.searchUserData,
        // onChanged: allUserProvider.textChanged,
      ),
    );
  }
}
