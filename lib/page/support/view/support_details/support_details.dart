import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/support/content/priority_type.dart';
import 'package:onesthrm/page/support/content/type_name_widget.dart';

class SupportDetails extends StatelessWidget {
  final SupportModel? supportModel;

  const SupportDetails({Key? key, this.supportModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('support_ticket_details'),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tr("id"),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  supportModel?.subject ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                PriorityType(supportModel: supportModel),
                const SizedBox(
                  width: 8,
                ),
                TypeNameWidget(supportModel: supportModel),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              tr("created_on"),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              supportModel?.date ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              tr("details"),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              supportModel?.description ??
                  "this_data_is_static_cause_there_is_no_API_yet".tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              tr("photos"),
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: supportModel?.file ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                  placeholder: (context, url) => Center(
                    child: Image.asset("assets/images/app_icon.png"),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ],
        ),
      ),
    );
  }
}
