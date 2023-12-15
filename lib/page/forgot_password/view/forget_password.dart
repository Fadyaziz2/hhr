import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/page/forgot_password/content/change_password.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr("forget_password"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("enter_your_email_address_to_reset_your_password"),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                // controller:
                //     context.watch<ForgetPassProvider>().emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: tr("enter_your_email"),
                  labelStyle: const TextStyle(fontSize: 12),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Visibility(
              //     // visible:
              //     //     context.watch<ForgetPassProvider>().emailError != null,
              //     child: Text(
              //   "",
              //   style: const TextStyle(color: Colors.red),
              // )),
              // Visibility(
              //     visible: context.watch<ForgetPassProvider>().error != null &&
              //         context.watch<ForgetPassProvider>().emailError == null,
              //     child: Text(
              //       context.watch<ForgetPassProvider>().error ?? "",
              //       style: const TextStyle(color: Colors.red),
              //     )),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 45,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    NavUtil.navigateScreen(
                        context, const ChangePassword(email: ''));
                    // context
                    //     .read<ForgetPassProvider>()
                    //     .getVerificationCode(context);
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
                  child: Text(tr("send_verification_code"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
