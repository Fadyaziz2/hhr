import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

class LeaveTypeContent extends StatelessWidget {
  const LeaveTypeContent({
    super.key,
    required this.data,
  });

  final ApprovalDetailsData? data;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.labelSmall;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Leave Type',
                          style: textStyle!
                              .copyWith(color: const Color(0xFF6B6A70))),
                      Chip(
                        label: Text(data?.type ?? '', style: textStyle),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Leave Status',
                          style: textStyle.copyWith(
                              color: const Color(0xFF6B6A70))),
                      Chip(
                        backgroundColor: Color(
                          int.parse(data?.colorCode ?? "0.0"),
                        ),
                        label: Text(
                          data?.status ?? '',
                          style: textStyle.copyWith(color: Colors.white),
                        ),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Form - To',
                          style: textStyle.copyWith(
                              color: const Color(0xFF6B6A70))),
                      Chip(
                        label: Text(data?.period ?? '', style: textStyle),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Leave Balance',
                          style: textStyle.copyWith(
                              color: const Color(0xFF6B6A70))),
                      Chip(
                        label: Text(
                            '${data?.totalUsed} / ${data?.availableLeave} Days',
                            style: textStyle),
                        shape: const StadiumBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
