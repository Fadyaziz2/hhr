import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import 'event_card.dart';

class HomeHeader extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeHeader(
      {Key? key,
      required this.settings,
      required this.user,
      required this.dashboardModel})
      : super(key: key);

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
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8.0,
                ),
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
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${user?.user?.name}',
                          style: const TextStyle(
                              fontSize: 15,
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
                if (settings?.data?.timeWish != null ||
                    dashboardModel?.data?.config?.timeWish != null)
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
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'today_summary'.tr(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: Colors.white,
                    letterSpacing: 0.5),
              ),
            ),
            const SizedBox(
              height: 8.0,
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
