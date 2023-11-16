import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_bloc.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_event.dart';
import 'package:onesthrm/page/daily_leave/bloc/daily_leave_state.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/card_tile_with_content.dart';
import 'package:onesthrm/res/widgets/common_elevated_button.dart';

class LeaveTypeViewScreen extends StatelessWidget {
  final LeaveListDatum? data;
  final DailyLeaveState? state;

  const LeaveTypeViewScreen({super.key, this.data, this.state});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final bloc = context.read<DailyLeaveBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.leaveType ?? ''),
      ),
      body: BlocBuilder<DailyLeaveBloc, DailyLeaveState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CardTileWithContent(
                              title: 'Name',
                              value: data?.staff ?? '',
                            ),
                            CardTileWithContent(
                              title: 'Designation',
                              value: data?.designation ?? '',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'Leave Type',
                                    value: data?.leaveType ?? '',
                                  ),
                                ),
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'Status',
                                    value: data?.status ?? '',
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'Leave Data On',
                                    value: data?.date ?? '',
                                  ),
                                ),
                                Expanded(
                                  child: CardTileWithContent(
                                    title: 'Time',
                                    value: data?.time ?? '',
                                  ),
                                ),
                              ],
                            ),
                            CardTileWithContent(
                              title: 'Reason',
                              value: data?.reason ?? '',
                            ),
                            CardTileWithContent(
                              title: 'Manager Approval',
                              value: data?.approvalDetails?.managerApproval ??
                                  'N/A',
                            ),
                            CardTileWithContent(
                              title: 'HR Approval',
                              value: data?.approvalDetails?.hrApproval ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: data?.status != 'Approved' && user?.user?.isHr == true,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(
                                  userId: user!.user!.id!,
                                  leaveId: data!.id!,
                                  leaveStatus: 'approved',
                                  context: context,
                                ));
                              },
                              title: const Text(
                                'Approved',
                                style: TextStyle(color: Colors.white),
                              ),
                              bgColor: colorPrimary,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomElevatedButton(
                              onTap: () {
                                bloc.add(LeaveAction(
                                  userId: user!.user!.id!,
                                  leaveId: data!.id!,
                                  leaveStatus: 'rejected',
                                  context: context,
                                ));
                              },
                              title: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                              bgColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              NetworkStatus.loading == bloc.state.status
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}
