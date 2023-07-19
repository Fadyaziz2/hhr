import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';

import '../../attendance/content/animated_circular_button.dart';

class BreakContent extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakContent({Key? key, required this.homeBloc}) : super(key: key);

  @override
  State<BreakContent> createState() => _BreakContentState();
}

class _BreakContentState extends State<BreakContent>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  final CustomTimerController controllerBreakTimer = CustomTimerController();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print("resumed");
        }
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print("inactive");
        }
        // Handle this case
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("inactive");
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("detached");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text.rich(
               TextSpan(
                children: [
                  TextSpan(
                      text: 'You have already taken ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF555555))),
                  TextSpan(
                      text: "00:08:15",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent)),
                  TextSpan(
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
            height: 20,
          ),
          CustomTimer(
              controller: controllerBreakTimer,
              begin: const Duration(hours: 06, minutes: 30, seconds: 10),
              end: const Duration(days: 1),
              builder: (remaining) {
                return Text(
                    "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                    style: GoogleFonts.cambay(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ));
              }),
          const AnimatedCircularButton(),
        ],
      ),
    );
  }
}
