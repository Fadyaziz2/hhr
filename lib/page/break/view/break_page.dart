import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../bloc/break_bloc.dart';
import '../content/break_content.dart';

class BreakScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final DashboardModel? dashboardModel;

  const BreakScreen({Key? key, required this.homeBloc,required this.dashboardModel}) : super(key: key);

  static Route route({required HomeBloc homeBloc,required DashboardModel? dashboardModel}) {
    return MaterialPageRoute(builder: (_) => BreakScreen(homeBloc: homeBloc,dashboardModel: dashboardModel,));
  }

  @override
  Widget build(BuildContext context) {

    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => BreakBloc(metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'),),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF00CCFF),
                    colorPrimary,
                  ],
                  begin: FractionalOffset(3.0, 0.0),
                  end: FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: Text(
            "Break time",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: appBarColor),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Lottie.asset(
                    'assets/images/ic_report_lottie.json',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BreakContent(homeBloc: homeBloc,dashboard: dashboardModel,),
      ),
    );
  }
}
