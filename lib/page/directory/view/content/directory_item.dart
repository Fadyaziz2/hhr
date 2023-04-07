import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../res/const.dart';

class DirectoryItem extends StatelessWidget {

  final Directory directory;

  const DirectoryItem({Key? key,required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150.0,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 4.0,
            blurRadius: 16.0
          )
        ],
        // border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          ListTile(
            title: Text(
              '${directory.name}',
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
                Text(directory.designation  ?? '',
                    style: TextStyle(fontSize: 13.0, color: mainColor)),
                const SizedBox(
                  height: 4.0,
                ),
                Text('${directory.email}',
                    style: TextStyle(fontSize: 12.0, color: mainColor)),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  '${directory.avatar}',
              ),
              radius: 35.0,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>launchUrl(Uri.parse("tel://${directory.phone}")),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(color: Color(0xFFEA7B60),shape: BoxShape.circle),
                    child: const Icon(
                      Icons.call,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                InkWell(
                  onTap: () =>launchUrl(Uri.parse("sms:${directory.phone}")),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(color: Color(0xFF6D73DF),shape: BoxShape.circle),
                    child: const Icon(
                      Icons.sms,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                InkWell(
                  onTap: () async {
                    final Uri uri = Uri(
                      scheme: 'mailto',
                      path: '${directory.email}',
                    );
                    await launchUrl(uri);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(color: Color(0xFF4C9665),shape: BoxShape.circle),
                    child: const Icon(
                      Icons.email,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
