
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';

class CheckInOutCard extends StatelessWidget {

  final Settings? settings;
  final LoginData? user;

  const CheckInOutCard({Key? key,required this.settings,required this.user}) : super(key: key);

  final bool isCheckIn = true;
  final String checkStatus = "Check In";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 18.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () { },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    checkStatus ==
                        "Check In"
                        ? 'assets/home_icon/in.svg'
                        : 'assets/home_icon/out.svg',
                    height: 40,
                    width: 40,
                    placeholderBuilder: (BuildContext
                    context) =>
                        Container(
                            padding:
                            const EdgeInsets
                                .all(30.0),
                            child:
                            const CircularProgressIndicator()),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [
                      Text(
                          checkStatus == "Check In"
                              ? "Start time"
                              : "Done for today",
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
                      const Text(
                        'Check In',
                        style: TextStyle(
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
