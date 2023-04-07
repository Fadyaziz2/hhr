import 'package:club_application/page/login/bloc/login_bloc.dart';
import 'package:club_application/page/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import '../../../res/const.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);

  static Route route(){
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
