import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance_report/view/content/present_content.dart';
import 'package:onesthrm/page/attendance_report/view/content/weekendContent.dart';
import '../../../../res/common/toast.dart';
import 'absent_content.dart';
import 'holidayContent.dart';

class DailyReportListTile extends StatelessWidget {
  final DailyReport dailyReport;

  final Settings settings;

  const DailyReportListTile(
      {Key? key,
      required this.dailyReport,
      required this.settings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (dailyReport.status) {
      case "Present":
        return DailyReportTile(dailyReport: dailyReport, settings: settings);
      case "Absent":
        return AbsentContent(dailyReport: dailyReport);
      case "Weekend":
        return WeekendContent(dailyReport: dailyReport);
      case "Holiday":
        return HolidayContent(dailyReport: dailyReport,);
      case "...":
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(
                      dailyReport.weekDay ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    Text(
                      dailyReport.date ?? "",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          Opacity(
                            opacity: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DottedBorder(
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                strokeWidth: 1,
                                child: Text(
                                  dailyReport.status ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
