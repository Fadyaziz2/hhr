import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';

class CheckInCheckOutTime extends StatelessWidget {
  final DashboardModel homeData;

  const CheckInCheckOutTime({Key? key, required this.homeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              color: colorPrimary,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              homeData.data?.attendanceData?.inTime ?? "--:--",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "check in",
              style: TextStyle(
                  fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              color: colorPrimary,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              homeData.data?.attendanceData?.outTime ?? "--:--",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
           const Text(
              "check out",
              style: TextStyle(
                  fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              Icons.history,
              color: colorPrimary,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              homeData.data?.attendanceData?.stayTime ?? "--:--",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "working hr",
              style: TextStyle(
                  fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
