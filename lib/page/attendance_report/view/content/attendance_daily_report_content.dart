

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AttendanceDailyReportContent extends StatelessWidget {
  const AttendanceDailyReportContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          Center(
              child: Text(
                tr("daily_report"),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Column(
                children: [
                  Text(
                   "Sunday",
                    style:
                    TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                     "12/12",
                    style:
                    TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(width: 20,),
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
                            child: Text(
                              "IN",
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Visibility(
                            visible: true,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      style: BorderStyle.solid,
                                      width: 3.0,
                                    ),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DottedBorder(
                                    color: Colors.white,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    strokeWidth: 1,
                                    child: const Text(
                                       "At 10",
                                      style: TextStyle(
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
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueAccent),
                                      child: const Center(
                                          child: Text(
                                            'home',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                  // dailyReport?.checkInReason?.isNotEmpty ==
                                      true,
                                  child: InkWell(
                                    onTap: () {
                                      // getReasonIn(dailyReport);
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
                            visible:
                            // dailyReport?.checkOut?.isNotEmpty ==
                                true,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                      width: 3.0,
                                    ),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DottedBorder(
                                    color: Colors.white,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    strokeWidth: 1,
                                    child: const Text(
                                      // dailyReport?.checkOut ??
                                          "at 5 ",
                                      style: TextStyle(
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
                                  // dailyReport?.remoteModeOut?.isNotEmpty ==
                                      true,
                                  child: InkWell(
                                    onTap: () {
                                      // getLocationOut(dailyReport);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blueAccent),
                                        child: const Center(
                                            child: Text(
                                              // remoteModeOut,
                                              'Office',
                                              style: TextStyle(
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
                                  // dailyReport?.checkOutReason?.isNotEmpty ==
                                      true,
                                  child: InkWell(
                                    onTap: () {
                                      // getReasonOut(dailyReport);
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
                visible:
                // isMultiCheckIn ??
                    false,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // String? date = dailyReport?.fullDate;
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
          const SizedBox(height: 10,),
          Row(
            children: [
              const Column(
                children: [
                  Text(
                     "Saturday",
                    style:
                    TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  Text(
                   "14/12",
                    style:
                    TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      color: const Color(0xffF2F8FF),
                      child: Row(
                        children: [
                          Container(
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
                              child: const Text(
                               "Active",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
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
        ],
      ),
    );
  }
}
