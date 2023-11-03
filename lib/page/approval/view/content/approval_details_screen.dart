import 'package:flutter/material.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/approval/view/content/approval_details_content_tile.dart';
import 'package:onesthrm/res/const.dart';

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
        builder: (context, snapshot) {
          final data = snapshot.data?.approvalDetailsData;
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ApprovalDetailsContentTile(
                    title: 'Employee Name',
                    value: data?.name ?? '',
                  ),
                  ApprovalDetailsContentTile(
                    title: 'Designation',
                    value: data?.designation ?? '',
                  ),
                  ApprovalDetailsContentTile(
                    title: 'Department',
                    value: data?.department ?? '',
                  ),
                  ApprovalDetailsContentTile(
                    title: 'Request Leave',
                    value: data?.requestedOn ?? '',
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Leave Type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    const Color(0xFF6B6A70))),
                                    Chip(
                                      label: Text(data?.type ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall),
                                      shape: const StadiumBorder(),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Leave Status',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    const Color(0xFF6B6A70))),
                                    Chip(
                                      backgroundColor: Color(
                                        int.parse(data?.colorCode ?? "0.0"),
                                      ),
                                      label: Text(
                                        data?.status ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                      shape: const StadiumBorder(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Form - To',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    const Color(0xFF6B6A70))),
                                    Chip(
                                      label: Text(data?.period ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall),
                                      shape: const StadiumBorder(),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Leave Balance',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color:
                                                    const Color(0xFF6B6A70))),
                                    Chip(
                                      label: Text(
                                          '${data?.totalUsed} / ${data?.availableLeave} Days',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall),
                                      shape: const StadiumBorder(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 0.5),
                            bottom: BorderSide(
                                color: Colors.grey.shade300, width: 0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Substitute',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: const Color(0xFF6B6A70))),
                        const SizedBox(
                          height: 4,
                        ),
                        Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data?.substitute?.avatar ?? ''),
                            ),
                            title: Text(data?.substitute?.name ?? '',
                                style: Theme.of(context).textTheme.bodySmall),
                            subtitle: Text(data?.substitute?.designation ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ApprovalDetailsContentTile(
                    title: 'Employee Note',
                    value: data?.note ?? '',
                  ),
                  ApprovalDetailsContentTile(
                    title: 'Approves',
                    value: data?.apporover ?? 'N/A',
                  ),
                  Visibility(
                    // visible: data?.status != 'Cancel',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColorRed,
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
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
