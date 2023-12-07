import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/appointment/appoinment_list/content/upcoming_event_widgetg.dart';
import 'package:onesthrm/page/meeting/bloc/meeting_bloc.dart';
import 'package:onesthrm/page/meeting/view/meeting_create_page/meeting_create_page.dart';
import 'package:onesthrm/page/meeting/view/meeting_details_page/meeting_details_page.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';
import '../../../../res/nav_utail.dart';
import '../../../leave/view/content/leave_list_shimmer.dart';

class MeetingContent extends StatelessWidget {
  const MeetingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavUtil.navigateScreen(context, BlocProvider.value(value: context.read<MeetingBloc>(), child: const MeetingCreatePage()));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Meeting List"),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<MeetingBloc>().add(SelectDatePicker(context));
                },
                icon: const Icon(Icons.calendar_month_outlined))
          ],
        ),
        body: BlocBuilder<MeetingBloc, MeetingState>(
          builder: (BuildContext context, state) {
            if (state.status == NetworkStatus.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LeaveListShimmer(),
              );
            } else if (state.status == NetworkStatus.success) {
              return Column(
                children: [
                  state.meetingsListResponse?.data?.items?.isNotEmpty == true
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.meetingsListResponse?.data?.items?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.meetingsListResponse?.data?.items?[index];
                              return Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: InkWell(
                                    onTap: () {
                                      NavUtil.navigateScreen(context, MeetingDetailsPage(data: data));
                                    },
                                    child: EventWidgets(isAppointment: true, data: data!),
                                  ));
                            },
                          ),
                        )
                      : Expanded(child: Center(child: Text(tr("No Meeting Found"),
                            style: const TextStyle(color: colorGray, fontSize: 22, fontWeight: FontWeight.w500),)),)
                ],
              );
            } else if (state.status == NetworkStatus.failure) {
              return Center(
                child: Text("Failed to load Meeting List".tr(),
                  style: TextStyle(color: colorPrimary.withOpacity(0.4),
                  fontSize: 18, fontWeight: FontWeight.w500),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}
