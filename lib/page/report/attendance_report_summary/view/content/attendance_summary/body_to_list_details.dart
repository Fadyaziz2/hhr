import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/report/attendance_report_summary/view/content/attendance_summary/attendance_summary.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

import '../../../bloc/report_bloc.dart';

class BodyToListDetails extends StatelessWidget {
  const BodyToListDetails({super.key, required this.title, required this.type});

  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    final reportBloc = context.read<ReportBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance $title'),
      ),
      body: FutureBuilder(
        future: reportBloc.getSummaryToList(type: type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                snapshot.data?.data?.users?.isNotEmpty == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.data?.users?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final data = snapshot.data?.data?.users?[index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                    context,
                                    BlocProvider.value(
                                      value: context.read<ReportBloc>(),
                                      child:
                                          ProfileDetails(userId: data!.userId!),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${data?.avatar}'),
                                ),
                                title: Text(
                                  data?.name ?? '',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(data?.designation ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data?.checkIn ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.green),
                                    ),
                                    Text(
                                      data?.checkOut ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Expanded(child: Center(child: NoDataFoundWidget())),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
