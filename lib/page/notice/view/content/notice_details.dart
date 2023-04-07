import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meta_club_api/src/models/notice.dart';
import '../../../../res/const.dart';

class NoticeDetails extends StatelessWidget {

  final Notice notice;

  const NoticeDetails({Key? key,required this.notice}) : super(key: key);

  static Route route (Notice notice){
    return MaterialPageRoute(builder: (_) => NoticeDetails(notice: notice,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:const Text('Notice'),backgroundColor: mainColor,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 220.0,
            fit: BoxFit.cover,
            imageUrl: '${notice.image}',
            placeholder: (context, url) => Center(
              child: Image.asset("assets/images/placeholder.png"),
            ),
            errorWidget: (context, url, error) => Image.network('${notice.image}'),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'created by : ${notice.createdBy}',
                  style: const TextStyle(fontSize: 13,color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  notice.subject ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '${notice.date}',
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 10,),
                Text(
                  '${notice.description}',
                  style: const TextStyle(fontSize: 14,height: 1.4),
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
