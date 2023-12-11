import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance_report/view/content/attendance_report_out.dart';

import 'attendance_report_in.dart';

class DialogMultiAttendanceList extends StatelessWidget {
  final MultiAttendanceData? multiAttendanceData;

  const DialogMultiAttendanceList({super.key, this.multiAttendanceData});

  @override
  Widget build(BuildContext context) {
    String? remoteModeIn;
    String? remoteModeOut;
    String? checkInColor;
    String? checkOutColor;
    return SizedBox(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: multiAttendanceData?.dateWiseReport?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            DateWiseReport? dateWiseReport = multiAttendanceData?.dateWiseReport?[index];
            // remote mode In -> Home or Office
            remoteModeIn = (int.tryParse(dateWiseReport?.remoteModeIn ?? "0") == 0) ? "H" : "V";
            // remote mode Out -> Home or Office
            remoteModeOut = (int.tryParse(dateWiseReport?.remoteModeOut ?? "0") == 0) ? "H" : "V";

            /// CheckIn Status Color
            if (dateWiseReport?.checkInStatus == "OT") {
              checkInColor = "0xff46A44D"; //green Color
            } else if (dateWiseReport?.checkInStatus == "L") {
              checkInColor = "0xffF44336"; // red Color
            } else if (dateWiseReport?.checkInStatus == "A") {
              checkInColor = "0xff000000"; // Black Color
            } else if (dateWiseReport?.checkInStatus == "LT") {
              checkInColor = "0xff46A44D"; //green Color
            } else if (dateWiseReport?.checkInStatus == "LL") {
              checkInColor = "0xffFFC107"; // yellow Color
            } else {
              checkInColor = "0xff46A44D"; //green Color
            }

            /// CheckOut Status Color
            if (dateWiseReport?.checkOutStatus == "OT") {
              checkOutColor = "0xff46A44D"; //green Color
            } else if (dateWiseReport?.checkOutStatus == "LE") {
              checkOutColor = "0xffF44336"; // red Color
            } else if (dateWiseReport?.checkOutStatus == "L") {
              checkOutColor = "0xffF44336"; // red Color
            } else if (dateWiseReport?.checkOutStatus == "A") {
              checkOutColor = "0xff000000"; // Black Color
            } else if (dateWiseReport?.checkOutStatus == "LT") {
              checkOutColor = "0xff46A44D"; //green Color
            } else if (dateWiseReport?.checkOutStatus == "LL") {
              checkOutColor = "0xffFFC107"; // yellow Color
            } else {
              checkOutColor = "0xff46A44D"; //green Color
            }
            return Column(
              children: [
                AttendanceReportIn(dateWiseReport: dateWiseReport, checkInColor: checkInColor, remoteModeIn: remoteModeIn,),
                const SizedBox(height: 5),
                AttendanceReportOut(dateWiseReport: dateWiseReport, checkOutColor: checkOutColor, remoteModeOut: remoteModeOut,),
                const SizedBox(height: 16),
              ],
            );
          },
        ));
  }
}
