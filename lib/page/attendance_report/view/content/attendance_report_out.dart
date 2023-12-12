import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AttendanceReportOut extends StatelessWidget {
  final DailyReport? dateWiseReport;
  final String? checkOutColor;
  final String? remoteModeOut;

  const AttendanceReportOut({super.key,this.dateWiseReport,this.checkOutColor,this.remoteModeOut});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      color: const Color(0xffFCF6FF),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("OUT", style: TextStyle(fontSize: 10)),
          ),
          Visibility(
            visible: dateWiseReport?.checkOut?.isNotEmpty == true,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(int.parse(checkOutColor ?? "0xFF000000")),
                      style: BorderStyle.solid, width: 3.0,),
                    color: Color(int.parse(checkOutColor ?? "0xFF000000")),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DottedBorder(
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    strokeWidth: 1,
                    child: Text(dateWiseReport?.checkOut ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Visibility(
                  visible: dateWiseReport?.remoteModeOut?.isNotEmpty == true,
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: dateWiseReport?.checkOutLocation ?? "No Data Found",
                          toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green, textColor: Colors.white, fontSize: 18.0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(width: 16, height: 16,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                        child: Center(
                            child: Text(remoteModeOut ?? "H",
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ),
                ),
                Visibility(visible: dateWiseReport?.checkOutReason?.isNotEmpty == true,
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: dateWiseReport?.checkOutReason ?? "No Data Found",
                          toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green, textColor: Colors.white, fontSize: 18.0);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.article_outlined, color: Colors.blue, size: 18,),
                    ),
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
