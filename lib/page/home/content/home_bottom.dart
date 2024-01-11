import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import 'event_card.dart';

class HomeBottom extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeBottom(
      {super.key,
      required this.settings,
      required this.user,
      required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UpcomingEventCard(
          events: dashboardModel?.data?.upcomingEvents ?? [],
        ),
        SizedBox(
          height: 16.0.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'current_month_summary'.tr(),
            style: TextStyle(
                fontSize: 16.r,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
        ),
        SizedBox(
          height: 8.0.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
              children: List.generate(
            dashboardModel?.data?.currentMonth?.length ?? 0,
            (index) => EventCard2(
              data: dashboardModel?.data?.currentMonth![index],
              onPressed: () => null,
            ),
          )),
        ),
        SizedBox(height: 12.0.h),
      ],
    );
  }
}
