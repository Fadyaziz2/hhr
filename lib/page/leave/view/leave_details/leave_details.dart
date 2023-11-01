import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/leave/bloc/leave_bloc.dart';
import 'package:onesthrm/page/leave/view/content/build_container.dart';
import 'package:onesthrm/page/leave/view/content/leave_list_shimmer.dart';

import '../../../../res/widgets/custom_button.dart';
import '../content/leave_status.dart';

class LeaveDetails extends StatelessWidget {
  final int? requestId;

  const LeaveDetails({Key? key, this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
      create: (context) => LeaveBloc(
          metaClubApiClient: MetaClubApiClient(token: "${user?.user?.token}"))
        ..add(LeaveDetailsEven(requestId!, user!.user!.id!)),
      child: BlocBuilder<LeaveBloc, LeaveState>(
        builder: (context, state) {
          LeaveDetailsData? leaveDetailsData =
              state.leaveDetailsModel?.leaveDetailsData;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Leave Details"),
            ),
            body: leaveDetailsData != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 26,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 130, child: Text(tr("status"))),
                              LeaveStatus(
                                leaveDetailsData: leaveDetailsData,
                              )
                            ],
                          ),
                        ),
                        BuildContainer(
                            title: tr("requested_on"),
                            titleValue: leaveDetailsData.requestedOn ?? ""),
                        BuildContainer(
                            title: tr("type"),
                            titleValue: leaveDetailsData.type ?? ""),
                        BuildContainer(
                            title: tr("period"),
                            titleValue: leaveDetailsData.period ?? ""),
                        BuildContainer(
                            title: tr("total_days"),
                            titleValue:
                                '${leaveDetailsData.totalDays ?? ""} ${tr("days")}'),
                        BuildContainer(
                          title: tr("note"),
                          titleValue: leaveDetailsData.note ?? "",
                        ),
                        BuildContainer(
                          title: tr("substitute"),
                          titleValue:
                              leaveDetailsData.name ?? tr("add_substitute"),
                        ),
                        BuildContainer(
                          title: tr("approves"),
                          titleValue: leaveDetailsData.apporover,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 130, child: Text(tr("attachment"))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CachedNetworkImage(
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: "${user?.user?.avatar}",
                            placeholder: (context, url) => Center(
                              child: Image.asset(
                                  "assets/images/placeholder_image.png"),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            title: "Cancel Leave Request",
                            padding: 16,
                            clickButton: () {
                              context.read<LeaveBloc>().add(CancelLeaveRequest(
                                  leaveDetailsData.id!, context));
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: LeaveListShimmer(),
                  ),
          );
        },
      ),
    );
  }
}
