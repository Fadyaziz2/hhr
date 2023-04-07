import 'package:club_application/page/registration/bloc/registration_bloc.dart';
import 'package:club_application/page/registration/view/content/registration_content.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/const.dart';
import '../../../../res/dialogs/custom_dialogs.dart';

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
            style: ElevatedButton.styleFrom(primary: buttonColor),
            child: const Text('Register', style: TextStyle(fontSize: 16)),
          ),
        );
      },
    );
  }
}
