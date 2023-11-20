import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta_club_api/meta_club_api.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';

class CheckInCheckOutTime extends StatelessWidget {
  final DashboardModel homeData;

  const CheckInCheckOutTime({Key? key, required this.homeData})
      : super(key: key);

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
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(inTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "check_in".tr(),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              Icons.watch_later_outlined,
              color: colorPrimary,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(outTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "check_out".tr(),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            const Icon(
              Icons.history,
              color: colorPrimary,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(stayTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "working_hr".tr(),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
