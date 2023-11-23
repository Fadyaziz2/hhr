import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/leave/view/content/build_container.dart';
import 'package:onesthrm/page/report/leave_report/bloc/leave_report_bloc.dart';

class LeaveReportDetailsScreen extends StatelessWidget {
  final int leaveId;
  const LeaveReportDetailsScreen({super.key, required this.leaveId});

  @override
  Widget build(BuildContext context) {
    context.read<LeaveReportBloc>().add(LeaveReportDetails(leaveId: leaveId));
    final leaveBloc = context.watch<LeaveReportBloc>();
    return Scaffold(
        appBar: AppBar(title: Text("leave_details".tr())),
        body: Column(children: [
          const SizedBox(
            height: 26,
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 130, child: Text(tr("status"))),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(int.parse(leaveBloc.state.leaveDetailsModel
                              ?.leaveDetailsData?.colorCode ??
                          "")),
                      // color: Color(int.parse("0xFF000000")),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    color: Color(int.parse(leaveBloc.state.leaveDetailsModel
                            ?.leaveDetailsData?.colorCode ??
                        "")),
                    // color: Color(int.parse("0xFF000000")),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DottedBorder(
                    color: Colors.white,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    strokeWidth: 1,
                    child: Text(
                      '${leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.status}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),

          BuildContainer(
              title: tr("requested_on"),
              titleValue: leaveBloc
                      .state.leaveDetailsModel?.leaveDetailsData?.requestedOn ??
                  ""),
          BuildContainer(
              title: tr("type"),
              titleValue:
                  leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.type ??
                      ""),
          BuildContainer(
              title: tr("period"),
              titleValue:
                  leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.period ??
                      ""),
          BuildContainer(
              title: tr("total_days"),
              titleValue:
                  '${leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.totalDays ?? ""} ${tr("days")}'),
          BuildContainer(
            title: tr("note"),
            titleValue:
                leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.note ?? "",
          ),
          BuildContainer(
            title: tr("substitute"),
            titleValue:
                leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.name ??
                    tr("add_substitute"),
          ),
          BuildContainer(
            title: tr("approves"),
            titleValue:
                leaveBloc.state.leaveDetailsModel?.leaveDetailsData?.apporover,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 130, child: Text(tr("attachment"))),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: CachedNetworkImage(
          //     height: 200,
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //     imageUrl: "${user?.user?.avatar}",
          //     placeholder: (context, url) => Center(
          //       child: Image.asset(
          //           "assets/images/placeholder_image.png"),
          //     ),
          //     errorWidget: (context, url, error) =>
          //         const Icon(Icons.error),
          //   ),
          // ),
          const SizedBox(
            height: 40.0,
          )
        ]));
  }
}
