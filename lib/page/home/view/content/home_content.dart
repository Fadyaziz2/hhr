import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:onesthrm/page/home/router/home__menu_router.dart';
import 'package:onesthrm/page/internet_connectivity/view/device_offline_view.dart';
import '../../bloc/home_bloc.dart';

LocationServiceProvider locationServiceProvider = LocationServiceProvider();

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DeviceOfflineView(child: chooseTheme());
      },
    );
  }
}
