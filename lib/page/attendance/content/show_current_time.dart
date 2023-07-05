import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:meta_club_api/meta_club_api.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class ShowCurrentTime extends StatelessWidget {
  final DashboardModel homeData;

  const ShowCurrentTime({Key? key, required this.homeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ui.TextDirection direction = ui.TextDirection.ltr;
    return Opacity(
      opacity: homeData.data?.config?.isIpEnabled == true ? 0 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Directionality(
            textDirection: direction,
            child: DigitalClock(
              digitAnimationStyle: Curves.decelerate,
              is24HourTimeFormat: false,
              areaDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              hourMinuteDigitTextStyle: const TextStyle(
                color: Color(0xFF404A58),
                fontSize: 50,
              ),
              amPmDigitTextStyle: const TextStyle(
                  color: Color(0xFF404A58), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(DateFormat('yMMMMEEEEd', 'en').format(DateTime.now()),
            style: GoogleFonts.nunitoSans(
                fontSize: 20, color: const Color(0xFF404A58)),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
