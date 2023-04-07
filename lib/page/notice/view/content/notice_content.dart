import 'package:club_application/page/notice/bloc/notice_bloc.dart';
import 'package:meta_club_api/src/models/notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../contact/view/content/content_item.dart';
import 'notice_details.dart';

class NoticeContent extends StatelessWidget {
  final Notices notices;

  const NoticeContent({Key? key, required this.notices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return notices.notices.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              context.read<NoticeBloc>().add(NoticeLoadRequest());
              return;
            },
            child: ListView.builder(
              itemCount: notices.notices.length,
              itemBuilder: (context, index) {
                final notice = notices.notices.elementAt(index);

                return NoticeItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      NoticeDetails.route(notice),
                    );
                  },
                  notice: notice,
                );
              },
            ),
          )
        : const Center(
            child: Text('List is empty'),
          );
  }
}
