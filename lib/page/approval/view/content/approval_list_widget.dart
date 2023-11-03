import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/approval/approval.dart';
import 'package:onesthrm/page/approval/view/content/approval_details_screen.dart';

class ApprovalListWidget extends StatelessWidget {
  const ApprovalListWidget({
    super.key,
    required this.approvalLeaveRequestData,
  });

  final ApprovalLeaveRequest? approvalLeaveRequestData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            ApprovalDetailsScreen.route(
                approvalUserId: '${approvalLeaveRequestData?.userId}',
                approvalBloc: context.read<ApprovalBloc>(),
                approvalId: "${approvalLeaveRequestData!.id}"));
      },
      title: Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Chip(
                backgroundColor: Color(
                    int.tryParse(approvalLeaveRequestData?.colorCode ?? '') ??
                        0),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shape: const StadiumBorder(),
                label: Text(
                  approvalLeaveRequestData?.status ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white),
                )),
            Chip(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                shape: const StadiumBorder(),
                label: Text(approvalLeaveRequestData?.type ?? '',
                    style: Theme.of(context).textTheme.labelMedium)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                approvalLeaveRequestData?.message ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ]),
      subtitle: Row(
        children: [
          Chip(
              label: Text('Apply Date : ${approvalLeaveRequestData?.applyDate}',
                  style: Theme.of(context).textTheme.bodySmall))
        ],
      ),
    );
  }
}
