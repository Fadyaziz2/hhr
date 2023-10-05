import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance_report/view/content/content.dart';
import 'package:user_repository/user_repository.dart';

import '../../bloc/bloc.dart';

class AttendanceDailyReportContent extends StatelessWidget {
  const AttendanceDailyReportContent(
      {Key? key, required this.bloc, required this.user, required this.settings})
      : super(key: key);
  final AttendanceReportBloc bloc;
  final LoginData user;
  final Settings settings;

  @override
  Widget build(BuildContext context) {
    final listOfDailyReport = bloc.state.attendanceReport?.reportData?.dailyReport;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            tr("daily_report"),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          )),
          const SizedBox(
            height: 20,
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listOfDailyReport?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final data = listOfDailyReport?[index];
              return DailyReportListTile(dailyReport: data!, settings: settings,);
            },
          ),

          /// Bottom =========================

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                  child: Center(
                      child: Text(
                    tr("h"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  tr("check_in_check_out_from_home"),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blueAccent),
                  child: Center(
                      child: Text(
                    tr("v"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  tr("check_in_check_out_from_office"),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 0),
            child: Row(
              children: [
                IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.fileLines,
                      size: 15,
                      color: Colors.blueAccent,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (kDebugMode) {
                        print("Pressed");
                      }
                    }),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  tr("reason_for_late_check_in_early_check_out"),
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
