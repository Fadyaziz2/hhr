import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:onesthrm/page/home/content/home_bottom.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../content/breakCard.dart';
import '../../content/checkInOutCard.dart';
import '../../content/home_header.dart';

LocationServiceProvider locationServiceProvider = LocationServiceProvider();

class HomeEarthContent extends StatelessWidget {
  const HomeEarthContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final settings = context.read<HomeBloc>().state.settings;
        final user = context.read<AuthenticationBloc>().state.data;
        final homeData = context.read<HomeBloc>().state.dashboardModel;

        if (user?.user != null) {
          context.read<HomeBloc>().add(OnLocationEnabled(
              user: user!.user!, locationProvider: locationServiceProvider));
        }

        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return ListView(
              children: [
                ///top-header
                HomeHeader(
                    settings: settings, user: user, dashboardModel: homeData),

                ///check-in-out card
                CheckInOutCard(
                    settings: settings, user: user, dashboardModel: homeData),

                ///breakTime
                BreakCard(
                    settings: settings, user: user, dashboardModel: homeData),

                ///bottom-header
                HomeBottom(
                    settings: settings, user: user, dashboardModel: homeData),
              ],
            );
          },
        );
      },
    );
  }
}
