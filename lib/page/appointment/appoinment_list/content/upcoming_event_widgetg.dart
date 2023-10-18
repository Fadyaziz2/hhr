import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class EventWidgets extends StatelessWidget {
  const EventWidgets(
      {Key? key,
      required this.data,
      this.isAppointment = false,
      this.viewAllPressed})
      : super(key: key);

  final MeetingsItem? data;
  final bool? isAppointment;
  final Function()? viewAllPressed;

  @override
  Widget build(BuildContext context) {
    final values = data?.date?.split(' ');
    final month = values?[0];
    final date = values?[1];
    final subStringData = month?.substring(0, 3);
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        )),
        child: Row(children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: Colors.blue,
                  ),
                  child: Text(
                    '$subStringData'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '$date',
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data?.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0.5),
                ),
                Visibility(
                  visible: isAppointment!,
                  child: Row(
                    children: [
                      Text(
                        '${data?.time},',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: 0.5),
                      ),
                      Expanded(
                        child: Text(
                          ' ${data?.location}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF555555),
                              height: 1.4,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
