import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class ProfileDropDown extends StatelessWidget {

  final List<Department> items;
  final Department? item;
  final String title;
  final Function(Department?) onChange;

  const ProfileDropDown({Key? key,required this.items,required this.title,required this.onChange, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Department>(
              isExpanded: true,
              hint: Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
              value: item,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
              iconSize: 24,
              elevation: 16,
              onChanged: onChange,
              items: items.map<DropdownMenuItem<Department>>((Department value) {
                return DropdownMenuItem<Department>(
                  value: value,
                  child: Text(
                    '${value.title}',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}


class SimpleDropDown extends StatelessWidget {

  final List<String> items;
  final String title;

  const SimpleDropDown({Key? key,required this.items,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
              value: items.first,

              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
              iconSize: 24,
              elevation: 16,
              onChanged: (String? val) {

              },

              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    '$value',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}