import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/notice_list/bloc/notice_list_bloc.dart';
import 'package:onesthrm/page/notice_list/content/notice_list_content.dart';
import 'package:onesthrm/res/enum.dart';

import '../../../res/const.dart';
import '../../app/global_state.dart';

class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return BlocProvider(
      create: (context) => NotificationListBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}', companyUrl: baseUrl))
        ..add(LoadNotificationListData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr("notice")),
        ),
        body: BlocBuilder<NotificationListBloc, NoticeListState>(
            builder: (context, state) {
          if (state.status == NetworkStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == NetworkStatus.success) {
            if (state.noticeListModel != null) {
              return Column(
                children: [
                  state.noticeListModel?.data?.notices?.data?.isNotEmpty == true
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: state.noticeListModel?.data?.notices
                                    ?.data?.length ??
                                0,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final data = state
                                  .noticeListModel?.data?.notices?.data?[index];
                              return NoticeListContent(data: data);
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            tr("no_notice_found"),
                            style: const TextStyle(
                                color: Color(0x65555555),
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          )),
                        )
                  // : const SizedBox(),
                ],
              );
            }
          }
          if (state.status == NetworkStatus.failure) {
            return Center(child: Text('failed_to_load_notification'.tr()));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
