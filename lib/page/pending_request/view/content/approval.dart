import 'package:cached_network_image/cached_network_image.dart';
import 'package:club_application/page/pending_request/bloc/pending_bloc.dart';
import 'package:club_application/page/pending_request/view/content/reject_items.dart';
import 'package:club_application/res/const.dart';
import 'package:club_application/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'approval_items.dart';

class ApprovalContent extends StatelessWidget {

  const ApprovalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingBloc,PendingState>(builder: (context,state){
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        if (state.userListReponse != null) {
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Pending Request List'),
                backgroundColor: mainColor,
                bottom: const TabBar(
                  isScrollable: false,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.approval),
                      text: 'Approval',
                    ),
                    Tab(
                      icon: Icon(Icons.not_interested),
                      text: 'Reject',
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  ApprovalList(),
                  RejectList(),
                ],
              ),
            ),
          );
        }
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Failed to load Data'),
        );
      }
      return const SizedBox();
    });
  }
}
