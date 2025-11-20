import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meta_club_api/meta_club_api.dart';

class ShowCurrentTime extends StatefulWidget {
  final DashboardModel homeData;

  const ShowCurrentTime({super.key, required this.homeData});

  @override
  State<ShowCurrentTime> createState() => _ShowCurrentTimeState();
}

class _ShowCurrentTimeState extends State<ShowCurrentTime> {
  late final Stream<DateTime> _clockStream;

  @override
  void initState() {
    super.initState();
    _clockStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now(),
    ).asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    ui.TextDirection direction = ui.TextDirection.ltr;
    return Opacity(
      opacity: widget.homeData.data?.config?.isIpEnabled == true ? 0 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Directionality(
            textDirection: direction,
            child: StreamBuilder<DateTime>(
              stream: _clockStream,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                final now = snapshot.data ?? DateTime.now();
                final hourMinute = DateFormat('hh:mm').format(now);
                final period = DateFormat('a').format(now);

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Row(
                    key: ValueKey('$hourMinute$period'),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hourMinute,
                        style: TextStyle(
                          color: const Color(0xFF404A58),
                          fontSize: 32.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          period,
                          style: const TextStyle(
                            color: Color(0xFF404A58),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Text(
            DateFormat('yMMMMEEEEd', 'en').format(DateTime.now()),
            style: GoogleFonts.nunitoSans(fontSize: 16.sp, color: const Color(0xFF404A58)),
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
