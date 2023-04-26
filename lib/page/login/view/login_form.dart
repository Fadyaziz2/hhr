import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/const.dart';
import '../../../res/dialogs/custom_dialogs.dart';
import '../../registration/view/registration_page.dart';
import '../bloc/login_bloc.dart';

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
          if(state.status.isSubmissionSuccess){
            showLoginDialog(context: context,isSuccess: true,message: 'Authentication Successful');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                    child: Image.asset(
                      "assets/images/app_icon.png",
                      height: 130,
                      width: 130,
                    )),
                const SizedBox(
                  height: 32.0,
                ),
                const _EmailInput(),
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
                    style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
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

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('email_text_field'),
          onChanged: (phone) =>
              context.read<LoginBloc>().add(LoginEmailChange(email: phone)),
          decoration: InputDecoration(
            labelText: 'Email',
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            prefixIcon: const Icon(Icons.phone_android_rounded),
            prefixIconColor: mainColor,
            errorText: state.email.invalid ? 'Invalid email' : null,
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
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.visibility_off,
                color: colorPrimary,
              ),
              onPressed: () {

              },
            ),
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
