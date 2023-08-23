import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/natification/bloc/notification_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:provider/provider.dart';

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
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      if (state.status == NetworkStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == NetworkStatus.success) {
        if (state.notificationResponse != null) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(tr("notifications")),
                actions: [
                  Visibility(
                    visible: state.notificationResponse?.data?.notifications
                            ?.isNotEmpty ??
                        false,
                    // visible: true,
                    child: InkWell(
                      onTap: () {
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
              body: SafeArea(
                  child: Column(
                children: [
                  // provider.isLoading
                  //     ? provider.notificationsList!.isNotEmpty
                  //         ?
                  state.notificationResponse?.data?.notifications?.isNotEmpty ==
                          true
                      ? Expanded(
                          child: ListView.separated(
                            itemCount: state.notificationResponse?.data
                                    ?.notifications?.length ??
                                0,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final data = state.notificationResponse?.data
                                  ?.notifications?[index];

                              return InkWell(
                                onTap: () {
                                  // provider.getReadNotification(
                                  //     provider
                                  //         .notificationsList?[index]
                                  //         .id);
                                  // provider.getRoutSlag(
                                  //     context,
                                  //     provider
                                  //         .notificationsList?[index]
                                  //         .slag);
                                },
                                child: Container(
                                  color:
                                      // data?.isRead == true
                                      // ?
                                      Colors.transparent,
                                  // : const Color(0xD7E5F3FE),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          imageUrl: data?.image ??
                                              "assets/images/placeholder_image.png",
                                          placeholder: (context, url) => Center(
                                            child: Image.asset(
                                                "assets/images/placeholder_image.png"),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/placeholder_image.png"),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            children: [
                                              Text(
                                                data?.title ?? '',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("${data?.body}"),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${data?.date} ",
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
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
              )));
        }
      }
      if (state.status == NetworkStatus.failure) {
        return const Center(
          child: Text('Failed to load Notification'),
        );
      }
      return const SizedBox();
    });
  }
}
