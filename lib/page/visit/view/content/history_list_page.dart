import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/no_data_found_widget.dart';
import '../../../leave/view/content/leave_list_shimmer.dart';
import '../../bloc/visit_bloc.dart';

class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitState>(
      builder: (BuildContext context, state) {
        if (state.status == NetworkStatus.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LeaveListShimmer(),
          );
        } else if (state.status == NetworkStatus.success) {
          return state.visitListResponse?.visitList?.myVisits?.isNotEmpty ==
                  true
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                      itemCount:
                          state.historyListResponse?.data?.history?.length ?? 0,
                      itemBuilder: (context, index) {
                        History? myHistoryList =
                            state.historyListResponse?.data?.history?[index];

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: Card(
                                elevation: 2,
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Stack(
                                    children: [
                                      const Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.blueAccent,
                                              size: 20,
                                            )),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                myHistoryList?.month ?? "",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                myHistoryList?.day ?? "",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myHistoryList?.title ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${myHistoryList?.started ?? ""} - ${myHistoryList?.reached ?? ""}",
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color(int.parse(
                                                          myHistoryList
                                                                  ?.statusColor ??
                                                              "0xFF1FB89E")),
                                                      style:
                                                          BorderStyle.solid,
                                                      width: 3.0,
                                                    ),
                                                    color: Color(int.parse(
                                                        myHistoryList
                                                                ?.statusColor ??
                                                            "0xFF1FB89E")),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: DottedBorder(
                                                    color: Colors.white,
                                                    borderType:
                                                        BorderType.RRect,
                                                    radius:
                                                        const Radius.circular(
                                                            5),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                    strokeWidth: 1,
                                                    child: Text(
                                                      myHistoryList?.status ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                        // return VisitListItem(
                        //   myVisit: myVisit,
                        // );
                      }),
                )
              : const NoDataFoundWidget();
        } else if (state.status == NetworkStatus.failure) {
          return Center(
            child: Text(
              "failed_to_load_leave_list".tr(),
              style: TextStyle(
                  color: colorPrimary.withOpacity(0.4),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
