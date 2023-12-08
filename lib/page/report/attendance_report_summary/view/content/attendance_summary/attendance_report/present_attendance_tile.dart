import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/common/functions.dart';
import 'package:onesthrm/res/common/toast.dart';

import 'present_attendance_in_tile.dart';
import 'present_attendance_out_tile.dart';

class PresentAttendanceTile extends StatelessWidget {
  final DailyReport dailyReport;

  const PresentAttendanceTile({super.key, required this.dailyReport});

  @override
  Widget build(BuildContext context) {
    String? remoteModeIn;
    String? remoteModeOut;

    // remote mode In -> Home or Office
    remoteModeIn =
        (int.tryParse(dailyReport.remoteModeIn ?? "1") == 0) ? "H" : "V";

// remote mode Out -> Home or Office
    remoteModeOut =
        (int.tryParse(dailyReport.remoteModeOut ?? "0") == 0) ? "H" : "V";

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
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                Text(
                  dailyReport.date ?? "",
                  style: const TextStyle(color: Colors.black54, fontSize: 20),
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Text(
                          "in",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ).tr(),
                      ),
                      const SizedBox(width: 20.0),
                      PresentAddressInTile(
                          dailyReport: dailyReport, remoteModeIn: remoteModeIn),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "out".tr(),
                          style: const TextStyle(
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
                                  color: Color(int.parse(getInOutColor(
                                      status: dailyReport.checkOutStatus))),
                                  style: BorderStyle.solid,
                                  width: 3.0,
                                ),
                                color: Color(int.parse(getInOutColor(
                                    status: dailyReport.checkOutStatus))),
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
                                ).tr(),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            PresentAddressOutTile(
                                dailyReport: dailyReport,
                                remoteModeOut: remoteModeOut),
                            Visibility(
                              visible: dailyReport.checkOutReason?.isNotEmpty ==
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
        ],
      ),
    );
  }
}
