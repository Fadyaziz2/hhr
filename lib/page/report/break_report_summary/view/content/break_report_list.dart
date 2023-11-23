import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesthrm/page/report/break_report_summary/break_report.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/shimmers.dart';

class BreakReportList extends StatelessWidget {
  const BreakReportList({
    super.key,
    required this.breakUserId,
  });

  final String breakUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('break_time_report')),
      ),
      body: FutureBuilder(
        future: context
            .read<BreakBloc>()
            .getBreakSummaryHistoryList(breakUserId: breakUserId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final breakHistory = snapshot.data?.data?.breakHistory?.todayHistory;
            return Column(
              children: [
                Container(
                  color: const Color(0xff6AB026),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${tr('total_break_time')}:",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 16, color: Colors.white),
                      ),
                      // ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        snapshot.data?.data?.totalBreakTime ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "digitalNumber"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: breakHistory?.length ?? 0,
                    itemBuilder: (context, index) {
                      final data = breakHistory?[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                               SizedBox(
                                width: 100,
                                child: Text(
                                  data?.breakTimeDuration ?? '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                width: 3,
                                color: colorPrimary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Break",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(data?.breakBackTime ?? ''),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TileShimmer(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
