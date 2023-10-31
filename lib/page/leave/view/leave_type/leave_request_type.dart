import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';
import '../../../../res/nav_utail.dart';
import '../../../../res/widgets/custom_button.dart';
import '../leave_calendar/leave_calendar.dart';

class LeaveRequestType extends StatelessWidget {
  const LeaveRequestType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => LeaveBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}"))
        ..add(LeaveRequestTypeEven(context)),
      child: BlocBuilder<LeaveBloc, LeaveState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Leave Request Type"),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    title: "Next",
                    padding: 16,
                    clickButton: () {
                      NavUtil.replaceScreen(
                          context,
                          LeaveCalendar(
                            leaveRequestTypeId: state.selectedRequestType?.id,
                          ));
                    },
                  ),
                ),
              ),
              body: state.leaveRequestType?.leaveRequestType?.availableLeave !=
                      null
                  ? state.leaveRequestType?.leaveRequestType?.availableLeave?.isNotEmpty ==
                          true
                      ? ListView.separated(
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          itemCount: state.leaveRequestType?.leaveRequestType
                                  ?.availableLeave?.length ??
                              0,
                          itemBuilder: (context, index) {
                            AvailableLeaveType? availableLeave = state
                                .leaveRequestType
                                ?.leaveRequestType
                                ?.availableLeave?[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 4,
                              child: RadioListTile<AvailableLeaveType>(
                                value: availableLeave!,
                                title: Row(
                                  children: [
                                    Text(
                                      "${availableLeave.type}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${availableLeave.leftDays} ${tr("days_left")}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ).tr(),
                                  ],
                                ),
                                groupValue: state.selectedRequestType,
                                onChanged: (AvailableLeaveType? value) {
                                  context.read<LeaveBloc>().add(
                                      SelectedRequestType(context, value!));
                                  if (kDebugMode) {
                                    print(value.type);
                                  }
                                },
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 5))
                      : const NoDataFoundWidget()
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: LeaveListShimmer(),
                    ));
        },
      ),
    );
  }
}
