import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:onesthrm/page/forgot_password/content/change_password_body_content.dart';
import 'package:onesthrm/res/const.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final ForgotPasswordBody forgotPasswordBody;

  const ChangePassword(
      {super.key, required this.email, required this.forgotPasswordBody});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ChangePasswordBodyContent(
          forgotPasswordBody: widget.forgotPasswordBody,
          email: widget.email,
        ));
  }
}
