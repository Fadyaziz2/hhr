import 'package:flutter/material.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/approval/view/content/approval_details_tile_content.dart';
import 'package:onesthrm/page/approval/view/content/substitute_content.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/enum.dart';

import 'leave_type_content.dart';

class ApprovalDetailsScreen extends StatelessWidget {
  const ApprovalDetailsScreen(
      {Key? key,
      required this.approvalUserId,
      required this.bloc,
      required this.approvalId})
      : super(key: key);

  final String approvalUserId;
  final String approvalId;
  final ApprovalBloc bloc;

  static Route route(
      {required ApprovalBloc approvalBloc,
      required String approvalUserId,
      required String approvalId}) {
    return MaterialPageRoute(
      builder: (_) => ApprovalDetailsScreen(
        bloc: approvalBloc,
        approvalUserId: approvalUserId,
        approvalId: approvalId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval Details'),
      ),
      body: FutureBuilder(
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
                    ApprovalDetailsTileContent(title: 'Employee Name', value: data?.name ?? ''),
                    ApprovalDetailsTileContent(title: 'Department', value: data?.department ?? ''),
                    ApprovalDetailsTileContent(title: 'Designation', value: data?.designation ?? ''),
                    ApprovalDetailsTileContent(title: 'Request Leave On', value: data?.requestedOn ?? ''),
                    LeaveTypeContent(data: data),
                    SubstituteContent(data: data),
                    ApprovalDetailsTileContent(title: 'Employee Note', value: data?.note ?? ''),
                    ApprovalDetailsTileContent(title: 'Approves', value: data?.apporover ?? 'N/A'),
                    Visibility(
                      visible: isStatus,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                              onPressed: (){
                                /// approved == 1
                                if(bloc.state.status == NetworkStatus.success){
                                  bloc.add(ApproveOrRejectAction(approvalId: approvalId, type: 1, context: context));
                                }else{
                                  return;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorPrimary,
                                minimumSize: const Size.fromHeight(40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: const Text(
                                'Approved',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                /// reject == 6
                                if(bloc.state.status == NetworkStatus.success){
                                  bloc.add(ApproveOrRejectAction(approvalId: approvalId, type: 6, context: context));
                                }else{
                                  return;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                minimumSize: const Size.fromHeight(40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
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
    );
  }
}
