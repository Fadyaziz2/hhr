import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import 'content/home_content.dart';
class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      lazy: false,
      create: (_) => HomeBloc(metaClubApiClient: MetaClubApiClient(token : '${user?.user?.token}'))..add(LoadSettings()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              SizedBox(height: 16.0,),
              Expanded(child: HomeContent())
            ],
          ),
        ),
      ),
    );
  }
}
