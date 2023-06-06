
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';

class BreakCard extends StatelessWidget {

  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const BreakCard({Key? key,required this.settings,required this.user,required this.dashboardModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 18.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () { },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Lottie.asset(
                    'assets/images/tea_time.json',
                    height: 65.0,
                    width: 65.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                          dashboardModel?.data?.config?.breakStatus?.status != 'break_out'
                              ? "You're in break"
                              : "Take Coffee",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight
                                  .w500,
                              height: 1.5,
                              letterSpacing:
                              0.5)),
                      const SizedBox(
                          height: 10),
                       Text(
                        dashboardModel?.data?.config?.breakStatus?.status != 'break_out'
                            ?'${dashboardModel?.data?.config?.breakStatus?.breakTime}' : 'Break',
                        style: const TextStyle(
                            color: colorPrimary,
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
