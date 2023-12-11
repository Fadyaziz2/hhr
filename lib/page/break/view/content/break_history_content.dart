import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import '../../../../res/const.dart';
import '../../../app/global_state.dart';

class BreakHistoryContent extends StatelessWidget {

  final DashboardModel? dashboard;
  final BreakState state;

  const BreakHistoryContent({super.key,required this.state,required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "last_breaks",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ).tr(),
        if (state.breakReportModel?.data?.breakHistory?.todayHistory != null) ...[
          const SizedBox(height: 20.0),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                BreakTodayHistory? todayHistory = state.breakReportModel?.data?.breakHistory?.todayHistory?.elementAt(index);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        todayHistory?.breakTimeDuration ?? "",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 3,
                      color: globalState.get(breakStatus) == 'break_in'
                          ? const Color(0xFFE8356C)
                          : colorPrimary,
                    ),
                    const SizedBox(
                      width: 35.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todayHistory?.reason ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(todayHistory?.breakBackTime ?? ""),
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.breakReportModel?.data?.breakHistory?.todayHistory!.length ?? 0),
          const Divider(),
        ],
        if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory != null)
          const SizedBox(height: 8.0),
        if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory != null)
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                TodayHistory? todayHistory = dashboard
                    ?.data?.breakHistory?.breakHistory?.todayHistory!
                    .elementAt(index);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        todayHistory?.breakTimeDuration ?? "",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 3,
                      color: globalState.get(breakStatus) == 'break_in'
                          ? const Color(0xFFE8356C)
                          : colorPrimary,
                    ),
                    const SizedBox(
                      width: 35.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todayHistory?.reason ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(todayHistory?.breakBackTime ?? ""),
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {return const Divider();},
              itemCount: dashboard?.data?.breakHistory?.breakHistory?.todayHistory!.length ?? 0)
      ],
    );
  }
}
