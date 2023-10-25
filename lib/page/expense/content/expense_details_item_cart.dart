import 'package:flutter/material.dart';

class ExpenseDetailsItemCart extends StatelessWidget {
  const ExpenseDetailsItemCart({super.key, this.title, this.value});

  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
              Text(value ?? ''),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
