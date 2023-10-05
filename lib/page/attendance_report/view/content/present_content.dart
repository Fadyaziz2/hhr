import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../../res/common/functions.dart';
import '../../../../res/common/toast.dart';

class DailyReportTile extends StatelessWidget {
  final DailyReport dailyReport;
  final Settings settings;

  const DailyReportTile({Key? key, required this.dailyReport, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? remoteModeIn;
    String? remoteModeOut;

    /// remote mode In-> Home or Office
    int remoteIn = int.parse(dailyReport.remoteModeIn ?? "1");
    if (remoteIn == 0) {
      remoteModeIn = "H";
    } else {
      remoteModeIn = "V";
    }

    /// remote mode Out-> Home or Office
    int? remoteOut = int.tryParse(dailyReport.remoteModeOut ?? "0");
    if (remoteOut == 0) {
      remoteModeOut = "H";
    } else {
      remoteModeOut = "V";
    }


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
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffF2F8FF),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("IN",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Visibility(
                        visible: dailyReport.checkIn?.isNotEmpty == true,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(getInOutColor(status:dailyReport.checkInStatus))),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(getInOutColor(status:dailyReport.checkInStatus))),
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
                                  dailyReport.checkIn ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {
                                // getLocationIn(dailyReport);
                                getReasonIn(dailyReport.checkInLocation);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueAccent),
                                  child: Center(
                                      child: Text(
                                        remoteModeIn,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                              dailyReport.checkInReason?.isNotEmpty ==
                                  true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.checkInReason);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  color: const Color(0xffFCF6FF),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "OUT",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dailyReport.checkOut?.isNotEmpty == true,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(int.parse(getInOutColor(status:dailyReport.checkOutStatus))),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(getInOutColor(status:dailyReport.checkOutStatus))),
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
                                  dailyReport.checkOut ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Visibility(
                              visible:
                              dailyReport.remoteModeOut?.isNotEmpty ==
                                  true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.checkOutLocation);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blueAccent),
                                    child: Center(
                                        child: Text(
                                          remoteModeOut,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                              dailyReport.checkOutReason?.isNotEmpty ==
                                  true,
                              child: InkWell(
                                onTap: () {
                                  getReasonIn(dailyReport.checkOutReason);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.article_outlined,
                                    color: Colors.blue,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: settings.data?.multiCheckIn ?? false,
            child: Column(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    String? date = dailyReport.fullDate;
                    ///Todo: when multiple check in enable
                    // attendanceDailyReportApi(date, context);
                  },
                  child: Lottie.asset(
                    'assets/images/report_one.json',
                    height: 55,
                    width: 55,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
