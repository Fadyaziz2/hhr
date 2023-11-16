import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/content/home_bottom.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../content/breakCard.dart';
import '../../content/checkInOutCard.dart';
import '../../content/home_header.dart';

LocationServiceProvider locationServiceProvider = LocationServiceProvider();

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final settings = context.read<HomeBloc>().state.settings;
        final user = context.read<AuthenticationBloc>().state.data;
        final homeData = context.read<HomeBloc>().state.dashboardModel;

        if (user?.user != null) {
          locationServiceProvider.getCurrentLocationStream(
              uid: user!.user!.id!,
              metaClubApiClient:
                  MetaClubApiClient(token: '${user.user?.token}'));
        }

        return homeData != null
            ? BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return ListView(
                    children: [
                      ///top-header
                      HomeHeader(
                          settings: settings,
                          user: user,
                          dashboardModel: homeData),

                      ///check-in-out card
                      CheckInOutCard(
                          settings: settings,
                          user: user,
                          dashboardModel: homeData),

                      ///breakTime
                      BreakCard(
                          settings: settings,
                          user: user,
                          dashboardModel: homeData),

                      ///bottom-header
                      HomeBottom(
                          settings: settings,
                          user: user,
                          dashboardModel: homeData),
                    ],
                  );
                },
              )
            : const HomeContentShimmer();
      },
    );
  }
}
