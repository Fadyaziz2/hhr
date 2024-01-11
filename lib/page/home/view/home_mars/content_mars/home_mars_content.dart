import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/check_in_out_status_mars.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/current_month_mars.dart';
import 'package:onesthrm/page/home/view/home_mars/content_mars/upcoming_event_mars.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/page/profile/view/profile_page.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../content/home_content_shimmer.dart';
import '../../content/home_earth_content.dart';
import 'mars_today_summary_list.dart';

class HomeMarsContent extends StatelessWidget {
  const HomeMarsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        final user = context.read<AuthenticationBloc>().state.data;
        final homeData = context.read<HomeBloc>().state.dashboardModel;

        if (user?.user != null) {
          context.read<HomeBloc>().add(OnLocationEnabled(user: user!.user!, locationProvider: locationServiceProvider));
        }

        return homeData != null
            ? BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 100,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CupertinoSwitch(
                                  value: context.read<HomeBloc>().state.isSwitched,
                                  onChanged: (_) {
                                    context.read<HomeBloc>().add(
                                        OnSwitchPressed(
                                            user: context.read<AuthenticationBloc>().state.data?.user,
                                            locationProvider: locationServiceProvider));
                                  })),
                        ),

                        ///blue background
                        Positioned(
                          right: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/home_bg/home_background_one_aziz.png',
                            fit: BoxFit.cover,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            NavUtil.navigateScreen(
                                                context, const ProfileScreen());
                                          },
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "${user?.user?.avatar}",
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child: Image.asset(
                                                            "assets/home_bg/placeholder_image.png")),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(Icons.error)),
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25)
                                            ),
                                            child: CupertinoSwitch(
                                                value: context
                                                    .read<HomeBloc>()
                                                    .state
                                                    .isSwitched,
                                                onChanged: (_) {
                                                  context.read<HomeBloc>().add(
                                                      OnSwitchPressed(
                                                          user: context
                                                              .read<AuthenticationBloc>()
                                                              .state
                                                              .data
                                                              ?.user,
                                                          locationProvider:
                                                          locationServiceProvider));
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.135),


                                  ///Today Summary List ==========================
                                  const TodaySummaryListMars(),
                                  SizedBox(height: 18.h),
                                ],
                              ),
                            ),

                            const CheckInOutStatusActionMars(),

                            const CurrentMonthMars(),
                            ///upcoming events:----------------------
                            const UpcomingEventMars(),
                            SizedBox(height: 80.h),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            : const HomeContentShimmer();
      },
    );
  }
}
