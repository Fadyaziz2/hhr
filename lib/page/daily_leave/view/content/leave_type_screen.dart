import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/model/leave_list_model.dart';
import 'package:onesthrm/page/daily_leave/view/content/leave_type_view_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class LeaveTypeScreen extends StatelessWidget {
  final String? appBarName;
  final LeaveListModel leaveListData;

  const LeaveTypeScreen(
      {super.key, this.appBarName, required this.leaveListData});

  @override
  Widget build(BuildContext context) {
    final dailyLeaveBloc = context.read<DailyLeaveBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName ?? '').tr(),
      ),
      body: FutureBuilder(
        future: dailyLeaveBloc.onLeaveTypeList(leaveListData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                snapshot.data?.data?.data?.isNotEmpty == true
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.data?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = snapshot.data?.data?.data?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  leading: Image.network(
                                    '${data!.avater}',
                                    height: 42,
                                    width: 42,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.staff!),
                                      Text(
                                        data.leaveType!,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(data.time!),
                                      // if (!leaveStatus!.contains('approved') &&
                                      //     !leaveStatus!.contains('rejected'))
                                      InkWell(
                                        onTap: () => NavUtil.replaceScreen(
                                          context,
                                          BlocProvider.value(
                                            value:
                                                context.read<DailyLeaveBloc>(),
                                            child: LeaveTypeViewScreen(
                                              data: data,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colors.blue),
                                            child: Text(
                                              tr('view'),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                  children: [
                                    ListTile(
                                      title: RichText(
                                        text: TextSpan(
                                          text: '${tr('reason')}: ',
                                          style: DefaultTextStyle.of(context)
                                              .style
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: data.reason ?? '',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Expanded(child: Center(child: NoDataFoundWidget()))
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
