import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/page/login/login.dart';
import 'package:onesthrm/page/splash/bloc/splash_state.dart';
import '../../../res/nav_utail.dart';
import 'package:user_repository/src/models/user.dart';

class SplashBloc extends Cubit<SplashState>{

  SplashBloc({required BuildContext context,required MetaClubApiClient client,LoginData? data}):super(SplashState(context: context)){
    initSplash(context,data);
  }

  void initSplash(BuildContext context,LoginData? data){
    Future.delayed(const Duration(seconds: 2), () async {
      if (data?.user != null) {
        NavUtil.replaceScreen(context, const HomePage());
      } else {
        NavUtil.replaceScreen(context, const LoginPage());
      }
    });
  }

}