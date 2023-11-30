import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/page/visit/view/visit_page.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:shimmer/shimmer.dart';

import 'today_list_count_mars.dart';

class TodaySummaryListMars extends StatelessWidget {
  final DashboardModel? dashboardModel;

  const TodaySummaryListMars({super.key, this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    final dashboardModel = context.read<HomeBloc>().state.dashboardModel;
    return dashboardModel?.data?.today != null
        ? Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: primaryBorderColor),
                  borderRadius: BorderRadius.circular(10)),
              child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: (1.8 / .95),
                  children: [
                    TodayListCountMars(
                      onTap: () {
                        NavUtil.navigateScreen(context, const AppointmentScreen());
                      },
                      image: "assets/home_bg/appoinments.png",
                      title: "${dashboardModel!.data!.today![0].title}",
                      count: "0${dashboardModel.data!.today![0].number}",
                    ),
                    TodayListCountMars(
                      onTap: () {
                        // NavUtil.navigateScreen(context, const Meeti());
                      },
                      image: "assets/home_bg/meetings.png",
                      title: "${dashboardModel.data!.today![1].title}",
                      count: "0${dashboardModel.data!.today![1].number}",
                    ),
                    TodayListCountMars(
                      onTap: () {
                        NavUtil.navigateScreen(context, const VisitPage());
                      },
                      image: "assets/home_bg/visit.png",
                      title: "${dashboardModel.data!.today![2].title}",
                      count: "0${dashboardModel.data!.today![2].number}",
                    ),
                    TodayListCountMars(
                      onTap: () {
                        NavUtil.navigateScreen(context, const SupportPage());
                      },
                      image: "assets/home_bg/support_tickets.png",
                      title: "${dashboardModel.data!.today![3].title}",
                      count: "0${dashboardModel.data!.today![3].number}",
                    ),
                  ]),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 160.0,
                    height: 180.0,
                    child: Shimmer.fromColors(
                      baseColor: const Color(0xFFE8E8E8),
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 2),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: const Color(0xFFE8E8E8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
