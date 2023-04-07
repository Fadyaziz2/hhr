import 'package:club_application/page/login/bloc/login_bloc.dart';
import 'package:club_application/page/registration/view/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../res/const.dart';
import '../../../res/dialogs/custom_dialogs.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
             showLoginDialog(context: context,isSuccess: false,body: 'Authentication failed');
          }
          if(state.status.isSubmissionCanceled){
             showLoginDialog(context: context,isSuccess: false,message: '${state.user?.user?.name}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const _HeaderWidget(),
                const SizedBox(
                  height: 32.0,
                ),
                const _PhoneInput(),
                const SizedBox(
                  height: 18.0,
                ),
                const _PasswordInput(),
                const SizedBox(
                  height: 24.0,
                ),
                const _LoginButton(),
                const SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(RegistrationPage.route);
                    },
                    style: ElevatedButton.styleFrom(primary: buttonColor),
                    child: const Text('Registration'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://upload.wikimedia.org/wikipedia/en/5/5a/Shaheen_College_Logo_Dhaka.png',
          scale: 3,
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Welcome to club application',
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Login',
          style: TextStyle(
              fontSize: 27.0, color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextField(
          key: const Key('phone_text_field'),
          onChanged: (phone) =>
              context.read<LoginBloc>().add(LoginPhoneChange(phone: phone)),
          decoration: InputDecoration(
            labelText: 'Phone',
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.phone_android_rounded),
            prefixIconColor: mainColor,
            errorText: state.phone.invalid ? 'Invalid phone' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('password_text_field'),
          onChanged: (password) => context
              .read<LoginBloc>()
              .add(LoginPasswordChange(password: password)),
          decoration: InputDecoration(
            labelText: 'Password',
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.password),
            prefixIconColor: mainColor,
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(const LoginSubmit());
                  },
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                  child: const Text('Login'),
                ),
              );
      },
    );
  }
}
