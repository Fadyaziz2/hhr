import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../content/checkInOutCard.dart';
import '../../content/home_header.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<HomeBloc,HomeState>(
      builder: (context,state){

        final settings = context.read<HomeBloc>().state.settings;
        final user = context.read<AuthenticationBloc>().state.data;

        return Column(
          children: [
            ///top-header
            HomeHeader(settings: settings, user: user,),
            ///check-in-out card
            CheckInOutCard(settings: settings, user: user,),

          ],
        );
      },
    );
  }
}

