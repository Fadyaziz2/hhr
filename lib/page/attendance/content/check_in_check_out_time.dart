import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/page/attendance/bloc/attendance_bloc.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';

class CheckInCheckOutTime extends StatelessWidget {

  const CheckInCheckOutTime({super.key});

  @override
  Widget build(BuildContext context) {

    context.watch<AttendanceBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: colorPrimary,
              size: 22.r,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(inTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "check_in".tr(),
              style: TextStyle(fontSize: 12.r, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: colorPrimary,
              size: 22.r,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(outTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "check_out".tr(),
              style: TextStyle(fontSize: 12.r, color: Colors.grey),
            ),
          ],
        ),
        Column(
          children: [
            Icon(
              Icons.history,
              color: colorPrimary,
              size: 22.r,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              globalState.get(stayTime) ?? "--:--",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "working_hr".tr(),
              style: TextStyle(fontSize: 12.r, color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
