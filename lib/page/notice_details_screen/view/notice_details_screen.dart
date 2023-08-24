import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class NoticeDetailsScreen extends StatelessWidget {
  final int? noticeId;
  final String? image;
  final String? title;
  final String? date;
  final String? body;
  final NotificationResponse? notificationResponse;

  const NoticeDetailsScreen(
      {Key? key,
      this.noticeId,
      this.notificationResponse,
      this.title,
      this.image,
      this.body,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          tr("notice_details"),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // provider.noticeDetails?.data?.file != null
          //     ?

          CachedNetworkImage(
            width: double.infinity,
            height: 240,
            fit: BoxFit.contain,
            imageUrl: image ??
                // provider.noticeDetails?.data?.file ??
                "assets/images/placeholder_image.png",
            placeholder: (context, url) => Center(
              child: Image.asset("assets/images/placeholder_image.png"),
            ),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/placeholder_image.png"),
          ),
          // : const SizedBox(),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ??
                      // provider.noticeDetails?.data?.subject ??
                      "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date ??
                      // provider.noticeDetails?.data?.date ??
                      "",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  body ??
                      // provider.noticeDetails?.data?.description ??
                      "",
                  style: const TextStyle(fontSize: 14, height: 1.4),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
