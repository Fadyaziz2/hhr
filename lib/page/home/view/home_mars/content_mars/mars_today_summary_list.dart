import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/const.dart';
import 'package:shimmer/shimmer.dart';

import '../../../content/contents.dart';

class TodaySummaryListDesignTwo extends StatelessWidget {
  final DashboardModel? dashboardModel;

  const TodaySummaryListDesignTwo({super.key,this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return dashboardModel?.data?.today != null
        ? SingleChildScrollView(
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
    )
    /*Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.35,
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
                  childAspectRatio: (1.8 / .85),
                  children: [
                    ...
                    HomePageTotalCountCard(
                      ontap: () {
                        bloc?.getRoutSlag(context, bloc?.todayData![0].slug);
                      },
                      image: "assets/images/appoinments.png",
                      title: "${bloc!.todayData?[0].title}",
                      count: "0${bloc!.todayData?[0].number}",
                    ),
                    HomePageTotalCountCard(
                      ontap: () {
                        bloc?.getRoutSlag(context, bloc?.todayData![1].slug);
                      },
                      image: "assets/images/meetings.png",
                      title: "${bloc!.todayData?[1].title}",
                      count: "0${bloc!.todayData?[1].number}",
                    ),
                    HomePageTotalCountCard(
                      ontap: () {
                        bloc?.getRoutSlag(
                            context, bloc?.todayData![2].slug);
                      },
                      image: "assets/images/visit.png",
                      title: "${bloc!.todayData?[2].title}",
                      count: "0${bloc!.todayData?[2].number}",
                    ),
                    HomePageTotalCountCard(
                      ontap: () {
                        bloc?.getRoutSlag(
                            context, bloc?.todayData![3].slug);
                      },
                      image: "assets/images/support_tickets.png",
                      title: "${bloc!.todayData?[3].title}",
                      count: "0${bloc!.todayData?[3].number}",
                    ),
                  ]),
            ),
          )*/
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

class HomePageTotalCountCard extends StatelessWidget {
  const HomePageTotalCountCard(
      {super.key, this.image, this.title, this.count, this.ontap});

  final String? image;
  final String? title;
  final String? count;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Image.asset(
            image ?? "assets/images/placeholder_image.png",
            height: 60,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count ?? "",
                  style: const TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Text(
                  title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
