import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:onesthrm/res/const.dart';

class ChangePasswordBodyContent extends StatelessWidget {
  final String? email;
  final ForgotPasswordBody forgotPasswordBody;
  const ChangePasswordBodyContent(
      {super.key, this.email, required this.forgotPasswordBody});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                tr("reset_your_password"),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${tr("a_code_has_been_sent_to")} ${email} ${tr("use_the_code_here")}",
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(
                height: 26,
              ),
              TextField(
                // controller: provider.enterCodeTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr("enter_code"),
                  labelStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {
                  forgotPasswordBody.code = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: tr("new_password"),
                  labelStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {
                  forgotPasswordBody.password = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  labelText: 'confirm_password',
                  labelStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {
                  forgotPasswordBody.passwordConfirmation = value;
                },
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordBody.email = email;
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ForgotPassword(forgotPasswordBody, context));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => colorPrimary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(tr("reset_password"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
