import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/all_natification/view/notification_screen.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/content_neptune.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/page/profile/profile.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../../bloc/bloc.dart';
import '../../content/home_earth_content.dart';
import '../../home_mars/content_mars/content_mars.dart';
import '../../home_mars/content_mars/upcoming_event_mars.dart';

class HomeNeptuneContent extends StatelessWidget {
  const HomeNeptuneContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
      final user = context.read<AuthenticationBloc>().state.data;
      final homeData = context.read<HomeBloc>().state.dashboardModel;

      if (user?.user != null) {
        locationServiceProvider.getCurrentLocationStream(
            uid: user!.user!.id!,
            metaClubApiClient: MetaClubApiClient(token: '${user.user?.token}'));
      }

      return homeData != null
          ? BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [


                      ///blue background
                      Positioned(
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/home_bg/home_bg_neptune.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        right: 10,
                        top: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.grey.shade400.withOpacity(0.7),
                          ),
                          child: Align(
                              alignment: Alignment.bottomRight,
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
                                  })),
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
                                            imageUrl: "${user?.user?.avatar}",
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Image.asset(
                                                  "assets/home_bg/placeholder_image.png"),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            NavUtil.navigateScreen(context,
                                                const NotificationScreen());
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                                          },
                                          child: Image.asset(
                                            "assets/home_bg/aziz_notification.png",
                                            height: 36,
                                            width: 36,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.135),

                                ///Today Summary List ==========================
                                const TodaySummeryListNeptune()
                              ],
                            ),
                          ),

                          const CheckInOutStatusActionMars(),
                          // CheckStatusSectionDesignTwo(bloc: bloc),
                          //
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
    });
  }
}
