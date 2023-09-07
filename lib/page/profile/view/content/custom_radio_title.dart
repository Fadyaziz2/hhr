import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/support/view/create_support/bloc/create_support_bloc.dart';
import 'package:onesthrm/page/support/view/create_support/bloc/create_support_state.dart';
import 'package:onesthrm/page/support/view/create_support/model/body_create_support.dart';

class CustomRadioTitle extends StatelessWidget {
  final Function(BodyPrioritySupport?) onChanged;
  final String title;
  final String? initialData;
  final BodyPrioritySupport? value;

  const CustomRadioTitle(
      {Key? key,
        required this.onChanged,
        required this.title,
        required this.initialData, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateSupportBloc,CreateSupportState>(
      builder: (BuildContext context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<BodyPrioritySupport?>(
                      value: value,
                      groupValue: state.bodyPrioritySupport,
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
      },
    );
  }
}
