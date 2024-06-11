import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/break_card_mars.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/checkin_out_card_mars.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/current_month_mars.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/profile_mars.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import '../../content/home_earth_content.dart';
import 'home_bottom_mars.dart';

class HomeMarsContent extends StatelessWidget {
  const HomeMarsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        final settings = context.read<HomeBloc>().state.settings;
        final user = context.read<AuthenticationBloc>().state.data;
        final homeData = context.read<HomeBloc>().state.dashboardModel;

        if (user?.user != null) {
          context.read<HomeBloc>().add(OnLocationEnabled(user: user!.user!, locationProvider: locationServiceProvider));
        }

        return BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        ///blue background
                        Positioned(right: 0, left: 0,
                          child: Image.asset('assets/images/ic_banner_mars.png', fit: BoxFit.cover,),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///profile image
                            const ProfileMars(),
                            ///check-in-out card
                            CheckInOutCardMars(settings: settings, user: user, dashboardModel: homeData),
                            ///breakTime
                            BreakCardMars(settings: settings, user: user, dashboardModel: homeData),
                            ///bottom-header
                            HomeBottomMars(settings: settings, user: user, dashboardModel: homeData),
                            /// Current Month
                            const CurrentMonthMars(),
                            ///upcoming events:----------------------
                            SizedBox(height: 80.h),
                          ],
                        ),
                        Positioned(left: 0, right: 0, top: 30,
                            child: Image.asset("assets/images/ic_logo.png",height: 40,fit: BoxFit.fitHeight,)),
                        Positioned(right: 20, top: 30,
                            child: Image.asset("assets/images/ic_notification.png",height: 40,fit: BoxFit.fitHeight,)),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}