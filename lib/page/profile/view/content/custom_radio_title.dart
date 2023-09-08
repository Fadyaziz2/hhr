import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_bloc.dart';
import 'package:onesthrm/page/support/create_support_bloc/create_support_state.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';

class CustomRadioTitle extends StatelessWidget {
  final Function(BodyPrioritySupport?) onChanged;
  final String title;
  final BodyPrioritySupport? value;

  const CustomRadioTitle(
      {Key? key, required this.onChanged, required this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSupportBloc, CreateSupportState>(
      builder: (context, state) {
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
            groupValue: state.bodyPrioritySupport,
            onChanged: onChanged);
      },
    );
  }
}
