import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/all_natification/bloc/notification_bloc.dart';
import 'package:onesthrm/page/all_natification/content/notification_cart_content.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    return BlocProvider(
        create: (context) => NotificationBloc(
            metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
          ..add(LoadNotificationData()),
        child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(tr("notifications")),
                actions: [
                  Visibility(
                    visible: state.notificationResponse?.data?.notifications
                            ?.isNotEmpty ??
                        false,
                    // visible: true,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<NotificationBloc>()
                            .add(ClearNoticeButton());
                        context
                            .read<NotificationBloc>()
                            .add(LoadNotificationData());
                        // provider.clearNotificationApi();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              tr("clear_all"),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  // provider.isLoading
                  //     ? provider.notificationsList!.isNotEmpty
                  //         ?
                  state.notificationResponse?.data?.notifications?.isNotEmpty ==
                          true
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: state.notificationResponse?.data
                                    ?.notifications?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.notificationResponse?.data
                                  ?.notifications?[index];

                              return InkWell(
                                onTap: () {
                                  context.read<NotificationBloc>().add(
                                      RouteSlug(
                                          context: context,
                                          slugName: state
                                              .notificationResponse
                                              ?.data
                                              ?.notifications?[index]
                                              .slag,
                                          data: state.notificationResponse));
                                },
                                child: NotificationCartContent(data: data),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Text(
                            tr("no_notification_found"),
                            style: const TextStyle(
                                color: Color(0x65555555),
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          )),
                        )
                  // : const SizedBox(),
                ],
              ));
        }));
  }
}
