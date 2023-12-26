import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:onesthrm/page/home/content/home_bottom.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/internet_connectivity/view/device_offline_view.dart';
import 'package:onesthrm/page/language/bloc/language_bloc.dart';
import 'package:onesthrm/res/service/notification_service.dart';
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
        final homeData = context.read<HomeBloc>().state.dashboardModel;
        final user = context.read<AuthenticationBloc>().state.data;
        return homeData != null ? DeviceOfflineView(child:context.read<HomeBloc>().chooseTheme()) : const HomeContentShimmer();
      },
    );
  }
}
