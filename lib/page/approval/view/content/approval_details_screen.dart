import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/approval/view/content/approval_details_tile_content.dart';
import 'package:onesthrm/page/approval/view/content/substitute_content.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/widgets/common_elevated_button.dart';

import 'leave_type_content.dart';

class ApprovalDetailsScreen extends StatelessWidget {
  const ApprovalDetailsScreen(
      {super.key,
      required this.approvalUserId,
      required this.bloc,
      required this.approvalId});

  final String approvalUserId;
  final String approvalId;
  final ApprovalBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApprovalBloc, ApprovalState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Approval Details'),
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: bloc.onApprovalDetails(
                  approvalId: approvalId, approvalUserId: approvalUserId),
              builder: (_, snapshot) {
                final data = snapshot.data?.approvalDetailsData;
                final isStatus = bloc.isApproved(data?.status);
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ApprovalDetailsTileContent(
                              title: 'Employee Name', value: data?.name ?? ''),
                          ApprovalDetailsTileContent(
                              title: 'Department',
                              value: data?.department ?? ''),
                          ApprovalDetailsTileContent(
                              title: 'Designation',
                              value: data?.designation ?? ''),
                          ApprovalDetailsTileContent(
                              title: 'Request Leave On',
                              value: data?.requestedOn ?? ''),
                          LeaveTypeContent(data: data),
                          SubstituteContent(data: data),
                          ApprovalDetailsTileContent(
                              title: 'Employee Note', value: data?.note ?? ''),
                          ApprovalDetailsTileContent(
                              title: 'Approves',
                              value: data?.apporover ?? 'N/A'),
                          Visibility(
                            visible: isStatus,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomElevatedButton(
                                    onTap: () {
                                      /// approved == 1
                                      if (bloc.state.status == NetworkStatus.success) {
                                        bloc.add(ApproveOrRejectAction(
                                            approvalId: approvalId,
                                            type: 1,
                                            context: context));
                                      } else {
                                        return;
                                      }
                                    },
                                    title: const Text(
                                      'Approved',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: CustomElevatedButton(
                                    onTap: () {
                                      /// reject == 6
                                      if (bloc.state.status == NetworkStatus.success) {
                                        bloc.add(ApproveOrRejectAction(
                                            approvalId: approvalId,
                                            type: 6,
                                            context: context));
                                      } else {
                                        return;
                                      }
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
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: bloc.state.status == NetworkStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                      ))
                    : const SizedBox.shrink())
          ],
        ),
      );
    });
  }
}
