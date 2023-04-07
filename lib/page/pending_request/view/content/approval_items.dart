import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_application/page/pending_request/bloc/pending_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/const.dart';
import '../../../../res/enum.dart';

class ApprovalList extends StatelessWidget {
  const ApprovalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingBloc, PendingState>(builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        final list = state.userListReponse?.data?.pendingUserList;
        return ListView.builder(
          itemCount: list?.length ?? 0,
          itemBuilder: (context, index) {
            final item = list?.elementAt(index);

            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 4.0,
                        blurRadius: 16.0)
                  ],
                  // border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  ListTile(
                    title: Text(
                      item?.name ?? 'NA',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(item?.phone ?? 'NA',
                            style: TextStyle(fontSize: 13.0, color: mainColor)),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(item?.email ?? 'NA',
                            style: TextStyle(fontSize: 12.0, color: mainColor)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<PendingBloc>().add(
                                    ApprovalApprovedButton(
                                        userId: state.userListReponse?.data
                                            ?.pendingUserList?[index].id,
                                        action: "approve"));
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.approval,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Approved',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: mainColor,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: (){
                                context.read<PendingBloc>().add(
                                    ApprovalRejectButton(
                                        userId: state.userListReponse?.data
                                            ?.pendingUserList?[index].id,
                                        action: "reject"));
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.not_interested,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Rejected',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: mainColor,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(item?.avatar ?? 'NA'),
                      radius: 35.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
        );
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Failed to load profile'),
        );
      }
      return const SizedBox();
    });
  }
}
