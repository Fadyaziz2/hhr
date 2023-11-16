import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import '../../bloc/home_bloc.dart';


class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final homeData = context.read<HomeBloc>().state.dashboardModel;
        return homeData != null
            ? context.read<HomeBloc>().chooseTheme()
            : const HomeContentShimmer();
      },
    );
  }
}
