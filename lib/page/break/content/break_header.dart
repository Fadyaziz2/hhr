import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../res/const.dart';
import '../../app/global_state.dart';

class BreakHeader extends StatelessWidget {
  final CustomTimerController timerController;
  final DashboardModel? dashboardModel;

  const BreakHeader(
      {Key? key,
      required this.timerController,
      required this.dashboardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'You have already taken ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF555555))),
                TextSpan(
                    text: "${dashboardModel?.data?.breakHistory?.time}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.redAccent)),
                const TextSpan(
                    text: ' break',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF555555))),
              ],
            ),
          ),
        ),
        const Text(
          "You have not taken a break",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF555555)),
        ),
        const SizedBox(
          height: 8.0,
        ),
        CustomTimer(
            controller: timerController,
            begin: Duration(
              hours: int.parse(globalState.get(hour) ??'0'),
              minutes: int.parse(globalState.get(min) ?? '0'),
              seconds: int.parse(globalState.get(sec) ?? '0'),
            ),
            end: const Duration(days: 1),
            builder: (remaining) {
              globalState.set(hour, remaining.hours);
              globalState.set(min, remaining.minutes);
              globalState.set(sec, remaining.seconds);
              return Text(
                  "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                  style: GoogleFonts.cambay(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ));
            }),
      ],
    );
  }
}
