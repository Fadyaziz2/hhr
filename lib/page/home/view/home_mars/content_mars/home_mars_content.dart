import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/home/view/content/home_content.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';

import '../../content/home_content_shimmer.dart';
import 'mars_today_summary_list.dart';

class HomeMarsContent extends StatelessWidget {
  const HomeMarsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: ( context, state) {
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
                  return  SingleChildScrollView(
                    child: Stack(
                      children: [
                        ///blue background
                        Positioned(
                          right: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/images/home_background_one_aziz.png',
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
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAccount()));
                                          },
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                              imageUrl: "${user?.user?.avatar}",
                                              placeholder: (context, url) => Center(
                                                child: Image.asset(
                                                    "assets/images/placeholder_image.png"),
                                              ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              // Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                                            },
                                            child: Image.asset("assets/images/aziz_notification.png", height: 36,width: 36,))

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.135),

                                  ///Today Summary List ==========================
                                  TodaySummaryListDesignTwo(dashboardModel: homeData,)
                                ],
                              ),
                            ),


                            // CheckStatusSectionDesignTwo(bloc: bloc),
                            //
                            // CurrentMonthDesignTwo(bloc: bloc),
                            //
                            //
                            // ///upcoming events:----------------------
                            // // UpcomingEventDesign(provider: provider),
                            // UpcomingEventDesign(bloc: bloc),
                            const SizedBox(height: 50),

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
