import 'package:flutter/material.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';

class CustomRadioTitle extends StatelessWidget {
  final Function(BodyPrioritySupport?) onChanged;
  final String title;
  final BodyPrioritySupport? value;

  const CustomRadioTitle(
      {Key? key,
        required this.onChanged,
        required this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<BodyPrioritySupport?>(
                  value: value,
                  groupValue: BodyPrioritySupport(priorityName: 'Medium', priorityId: 20),
                  onChanged: onChanged),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
              )
            ],
          ),
        ),
      ],
    );
  }
}
