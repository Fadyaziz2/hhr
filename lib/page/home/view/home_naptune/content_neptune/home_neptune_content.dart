import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/break_card_neptune.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/checkIn_out_card_neptune.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/content_neptune.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/home_bottom_neptune.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import '../../../../../res/const.dart';
import '../../../bloc/bloc.dart';
import '../../content/home_earth_content.dart';
import '../../home_mars/content_mars/content_mars.dart';

class HomeNeptuneContent extends StatelessWidget {
  const HomeNeptuneContent({super.key});

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

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.0.h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 16.0),
                                                      child: Text(
                                                          settings?.data?.timeWish?.wish ?? homeData.data?.config?.timeWish?.wish ?? '',
                                                          style: TextStyle(fontSize: 20.r, color: Colors.white, fontWeight: FontWeight.bold)),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 16.0),
                                                      child: Text(
                                                        '${user?.user?.name}',
                                                        style:
                                                        TextStyle(fontSize: 14.r, fontWeight: FontWeight.bold, height: 1.5, color: Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 16.0),
                                                      child: Text(
                                                        settings?.data?.timeWish?.subTitle ?? homeData.data?.config?.timeWish?.wish ?? '',
                                                        style:
                                                        TextStyle(fontSize: 14.r, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (settings?.data?.timeWish != null || homeData.data?.config?.timeWish != null)
                                                SvgPicture.network(
                                                  settings?.data?.timeWish?.image ?? homeData.data?.config?.timeWish?.image ?? '',
                                                  semanticsLabel: 'sun',
                                                  height: 60.h,
                                                  width: 60.w,
                                                  placeholderBuilder: (BuildContext context) => const SizedBox(),
                                                ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.0.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: Text(
                                              'today_summary'.tr(),
                                              style: TextStyle(
                                                  fontSize: 16.r, fontWeight: FontWeight.w500, height: 1.5, color: Colors.white, letterSpacing: 0.5),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0.h,
                                          ),
                                          const TodaySummeryListNeptune()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.135),

                                const SizedBox(height: 20,),

                                ///Today Summary List ==========================
                                // const TodaySummeryListNeptune()
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          // const CheckInOutStatusActionMars(),

                          ///check-in-out card
                          CheckInOutCardNeptune(
                              settings: settings, user: user, dashboardModel: homeData),

                          ///breakTime
                          BreakCardNeptune(
                              settings: settings, user: user, dashboardModel: homeData),
                          // CheckStatusSectionDesignTwo(bloc: bloc),
                          //


                          ///bottom-header
                          HomeBottomNeptune(
                              settings: settings, user: user, dashboardModel: homeData),
                          const CurrentMonthMars(),
                          // ///upcoming events:----------------------
                          // const UpcomingEventMars(),
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
