import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import 'event_card.dart';

class HomeBottom extends StatelessWidget {

  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const HomeBottom({Key? key,required this.settings,required this.user,required this.dashboardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const SizedBox(height: 16.0,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Current month summary',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
        ),
        const SizedBox(height: 8.0,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
              children: List.generate(
                dashboardModel?.data?.currentMonth?.length ?? 0, (index) => EventCard2(
                data: dashboardModel?.data?.currentMonth![index],
                onPressed: () => null,
              ),
              )),
        ),
      ],
    );
  }
}
