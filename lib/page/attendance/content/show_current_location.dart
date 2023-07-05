import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/const.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ShowCurrentLocation extends StatelessWidget {
  final DashboardModel homeData;

  const ShowCurrentLocation({Key? key, required this.homeData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xffB7E3E8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/images/map_marker_icon.json',
                    height: 35, width: 35),
                Expanded(
                  child: SizedBox(
                    child: Text(
                      locationServiceProvider.place,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: const Color(0xFF404A58)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () async {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: colorPrimary,
                        child: Center(
                          child: Lottie.asset(
                            'assets/images/Refresh.json',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'refresh',
                        style: TextStyle(
                            color: colorPrimary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text("choose your remote mode",
            style: GoogleFonts.nunitoSans(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 42.0,
          child: ToggleSwitch(
            minWidth: 110.0,
            borderColor: const [
              colorPrimary,
            ],
            borderWidth: 3,
            cornerRadius: 30.0,
            activeBgColors: const [
              [Colors.white],
              [Colors.white]
            ],
            activeFgColor: colorPrimary,
            inactiveBgColor: colorPrimary,
            inactiveFgColor: Colors.white,
            initialLabelIndex: 0,
            icons: const [FontAwesomeIcons.house, FontAwesomeIcons.building],
            totalSwitches: 2,
            labels: const ['home', 'office'],
            radiusStyle: true,
            onToggle: (index) {
              /// RemoteModeType
              /// 0 ==> Home
              /// 1 ==> office
            },
          ),
        )
      ],
    );
  }
}
