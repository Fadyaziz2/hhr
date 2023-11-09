import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class NotificationCartContent extends StatelessWidget {
  const NotificationCartContent({
    super.key,
    required this.data,
  });

  final NotificationModelData? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl:
                      data?.image ?? "assets/images/placeholder_image.png",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/placeholder_image.png"),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/placeholder_image.png"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${data?.body}",
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${data?.date} ",
                    style: const TextStyle(color: Colors.black54),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
