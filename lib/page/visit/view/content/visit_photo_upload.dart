import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class VisitPhoneUpload extends StatelessWidget {
  const VisitPhoneUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Text(
            tr("phone_optional"),
            style:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 60.0,
            child: InkWell(
              onTap: () {
                // provider.pickImage(context);
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: DottedBorder(
                        color: Colors.blue,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        strokeWidth: 1,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                        )),
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:  3,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://www.w3schools.com/howto/img_avatar.png",
                            placeholder: (context, url) => Center(
                              child: Image.asset(
                                  "assets/images/placeholder_image.png"),
                            ),
                            errorWidget: (context, url, error) =>
                                Image.asset(
                                    "assets/images/placeholder_image.png"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
