import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/authentication/bloc/authentication_bloc.dart';
import 'package:onesthrm/page/natification/bloc/notification_bloc.dart';
import 'package:onesthrm/page/notice_details_screen/view/notice_details_screen.dart';
import 'package:onesthrm/page/notice_list/bloc/notice_list_bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';

class NoticeListScreen extends StatefulWidget {
  const NoticeListScreen({Key? key}) : super(key: key);

  @override
  State<NoticeListScreen> createState() => _NoticeListScreenState();
}

class _NoticeListScreenState extends State<NoticeListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;

    return BlocProvider(
      create: (context) => NotificationListBloc(
          metaClubApiClient: MetaClubApiClient(token: '${user?.user?.token}'))
        ..add(LoadNotificationListData()),
      child: BlocBuilder<NotificationListBloc, NoticeListState>(
          builder: (context, state) {
        if (state.status == NetworkStatus.loading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.status == NetworkStatus.success) {
          if (state.noticeListModel != null) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(tr("Notice")),
                  actions: [
                    Visibility(
                      visible: state.noticeListModel?.data?.notices?.data
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
                    state.noticeListModel?.data?.notices?.data?.isNotEmpty ==
                            true
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
                                final data = state.noticeListModel?.data
                                    ?.notices?.data?[index];

                                return InkWell(
                                  onTap: () {
                                    NavUtil.navigateScreen(
                                        context,
                                        NoticeDetailsScreen(
                                          image: data?.file,
                                          title: data?.subject,
                                          date: data?.date,
                                          body: data?.description,
                                        ));
                                    // context.read<NotificationBloc>().add(
                                    //     RouteSlug(
                                    //         context: context,
                                    //         slugName: state
                                    //             .notificationResponse
                                    //             ?.data
                                    //             ?.notifications?[index]
                                    //             .slag,
                                    //         data: state.notificationResponse));
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            imageUrl: data?.file ??
                                                "assets/images/placeholder_image.png",
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Image.asset(
                                                  "assets/images/placeholder_image.png"),
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
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
                                                  data?.subject ?? '',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // Text("${data?.body}"),
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
      }),
    );
  }
}
