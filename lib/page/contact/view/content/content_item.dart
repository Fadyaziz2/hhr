import 'package:flutter/material.dart';
import 'package:meta_club_api/src/models/notice.dart';

class NoticeItem extends StatelessWidget {

  final VoidCallback onTap;
  final Notice notice;

  const NoticeItem({Key? key,required this.onTap,required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.event_note),
      title: Text(
        '${notice.description}',
        maxLines: 2,
        style: const TextStyle(fontSize: 15.0),
      ),
      subtitle: Text( '${notice.date}',style: const TextStyle(fontSize: 11.0,height: 2.0),),
    );
  }
}
