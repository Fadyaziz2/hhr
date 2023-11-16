import 'dart:async';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/const.dart';
import '../../../../res/date_utils.dart';
import '../../../app/global_state.dart';

class BreakHeader extends StatelessWidget {
  final CustomTimerController timerController;
  final DashboardModel? dashboardModel;

  const BreakHeader(
      {super.key,
      required this.timerController,
      required this.dashboardModel});

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
            builder: (CustomTimerState state,CustomTimerRemainingTime remaining) {
              globalState.set(hour, remaining.hours);
              globalState.set(min, remaining.minutes);
              globalState.set(sec, remaining.seconds);

              return Text(
                  state == CustomTimerState.counting ?  "${remaining.hours}:${remaining.minutes}:${remaining.seconds}" : "00:00:00",
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

class HRMTimer extends StatefulWidget {
  const HRMTimer({super.key});

  @override
  State<HRMTimer> createState() => _HRMTimerState();
}

class _HRMTimerState extends State<HRMTimer> {

  String timer = '00:00:00';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      getSyncDuration().then((duration){
        if(duration != null){
          final t = duration.toString().split('.');
          t.removeLast();
          timer = duration.inHours < 10 ? '0${t.join(':')}' : t.join(':');
          if(mounted) {
            setState(() {});
          }
        }else{
          timer = '00:00:00';
          if(mounted) {
            setState(() {});
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Text(
        timer,
        style: GoogleFonts.cambay(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ));
  }
}
