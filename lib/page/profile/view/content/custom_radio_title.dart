import 'package:flutter/material.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';

class CustomRadioTitle extends StatelessWidget {
  final Function(BodyPrioritySupport?) onChanged;
  final String title;
  final BodyPrioritySupport? value;
  final BodyPrioritySupport? groupValue;

  const CustomRadioTitle(
      {Key? key, required this.onChanged, required this.title, this.value, this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<BodyPrioritySupport?>(
        contentPadding: EdgeInsets.zero,
        dense: true,
        value: value,
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontSize: 14),
        ),
        groupValue: groupValue,
        onChanged: onChanged);
  }
}
