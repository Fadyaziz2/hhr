import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class HomeHeader extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeHeader(
      {super.key,
      required this.settings,
      required this.user,
      required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Image.asset(
            'assets/images/home_background_one.png',
            fit: BoxFit.cover,
            color: colorPrimary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0.h,),
            Align(alignment: Alignment.bottomRight,child: CupertinoSwitch(value: context.read<HomeBloc>().state.isSwitched, onChanged: (_){
              context.read<HomeBloc>().add(OnSwitchPressed(user: context.read<AuthenticationBloc>().state.data?.user, locationProvider: locationServiceProvider));
            })),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                            settings?.data?.timeWish?.wish ??
                                dashboardModel?.data?.config?.timeWish?.wish ??
                                '',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${user?.user?.name}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          settings?.data?.timeWish?.subTitle ??
                              dashboardModel?.data?.config?.timeWish?.wish ??
                              '',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    if (settings?.data?.timeWish != null || dashboardModel?.data?.config?.timeWish != null)
                      SvgPicture.network(
                        settings?.data?.timeWish?.image ??
                            dashboardModel?.data?.config?.timeWish?.image ??
                            '',
                        semanticsLabel: 'sun',
                        height: 60,
                        width: 60,
                        placeholderBuilder: (BuildContext context) =>
                        const SizedBox(),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'today_summary'.tr(),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.white,
                    letterSpacing: 0.5),
              ),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                  children: List.generate(
                dashboardModel?.data?.today?.length ?? 0,
                (index) => EventCard(
                  data: dashboardModel?.data?.today![index],
                  onPressed: () => null,
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }
}
