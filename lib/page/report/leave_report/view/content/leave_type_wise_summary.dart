import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/report/leave_report/leave_report.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class LeaveTypeWiseSummary extends StatelessWidget {
  const LeaveTypeWiseSummary({super.key, required this.leaveData});

  final LeaveReportSummaryType leaveData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(leaveData.name ?? ''),
        ),
        body: FutureBuilder(
          future: context
              .read<LeaveReportBloc>()
              .onTypeWiseLeaveSummary(leaveData.id),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final leavesData = snapshot.data?.data?.leaves;
              return leavesData?.isNotEmpty == true
                  ? ListView.builder(
                      itemCount: leavesData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = leavesData?[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                    context,
                                    BlocProvider.value(
                                      value: context.read<LeaveReportBloc>(),
                                      child: LeaveReportDetailsScreen(
                                        leaveId: data!.id!,
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data?.avatar ??
                                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                ),
                                title: Text(data?.userName ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?.userDesignation ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reason : ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Expanded(
                                            child: Text(
                                              data?.reason ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                                trailing: Text("${data?.days} day"),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const NoDataFoundWidget();
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return const TileShimmer();
                },
              );
            }
          },
        ));
  }
}
