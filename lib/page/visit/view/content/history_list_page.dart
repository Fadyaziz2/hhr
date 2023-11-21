import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/visit/view/content/hitory_item.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';
import '../../../../res/widgets/no_data_found_widget.dart';
import '../../../leave/view/content/leave_list_shimmer.dart';
import '../../bloc/visit_bloc.dart';

class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            context.read<VisitBloc>().add(SelectMonthPicker(context));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month,
                color: colorPrimary,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Select Month",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<VisitBloc, VisitState>(
          builder: (BuildContext context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LeaveListShimmer(),
              );
            } else if (state.status == NetworkStatus.success) {
              return state.historyListResponse?.data?.history?.isNotEmpty ==
                      true
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          state.historyListResponse?.data?.history?.length ?? 0,
                      itemBuilder: (context, index) {
                        History? myHistoryList =
                            state.historyListResponse?.data?.history?[index];

                        return HistoryItem(
                          myHistoryList: myHistoryList,
                        );
                      },
                    )
                  : const Expanded(child: NoDataFoundWidget());
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
        ),
      ],
    );
  }
}
