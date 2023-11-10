import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(
            height: 20.h,
          ),
          Directionality(
            textDirection: direction,
            child: DigitalClock(
              digitAnimationStyle: Curves.decelerate,
              is24HourTimeFormat: false,
              areaDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              hourMinuteDigitTextStyle: TextStyle(
                color: const Color(0xFF404A58),
                fontSize: 50.sp,
              ),
              amPmDigitTextStyle: const TextStyle(
                  color: Color(0xFF404A58), fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            DateFormat('yMMMMEEEEd', 'en').format(DateTime.now()),
            style: GoogleFonts.nunitoSans(
                fontSize: 20, color: const Color(0xFF404A58)),
          ),
          SizedBox(
            height: 20.0.h,
          ),
        ],
      ),
    );
  }
}
