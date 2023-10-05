import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/registration/view/content/registration_content.dart';
import '../../../../res/const.dart';
import '../../bloc/registration_bloc.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (ctx, state) {
        return SizedBox(
          width: double.infinity,
          height: 45.0,
          child: ElevatedButton(
            onPressed: () {
              context.read<RegistrationBloc>().add(SubmitButton(items: bodyRegistration));
            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            child: const Text('Register', style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }
}
