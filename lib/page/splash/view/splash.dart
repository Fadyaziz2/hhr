import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/login/bloc/login_bloc.dart';
import 'package:onesthrm/page/splash/bloc/splash_bloc.dart';
import '../../../animation/bounce_animation/bounce_animation_builder.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route(){
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => SplashBloc(context: context,data: user,client: MetaClubApiClient(token : '${user?.user?.token}')),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BounceAnimationBuilder(
                  builder: (_,__){
                    return Center(
                      child: InteractiveViewer(
                        scaleEnabled: false,
                        boundaryMargin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Image.asset(
                          "assets/images/app_icon.png",
                          scale: 3,
                        ),
                      ),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}