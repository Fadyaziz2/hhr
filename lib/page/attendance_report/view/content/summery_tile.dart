import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesthrm/res/shimmers.dart';
import 'package:onesthrm/res/widgets/device_util.dart';

class SummeryTile extends StatelessWidget {
  const SummeryTile(
      {super.key,
      required this.title,
       this.titleValue,
      required this.color,
      this.onTap});

  final String title;
  final String? titleValue;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding: EdgeInsets.symmetric(vertical: DeviceUtil.isTablet ? 2.h : 2, horizontal: DeviceUtil.isTablet ? 16.w : 16),
          leading: Container(
            width: DeviceUtil.isTablet ? 16.sp : 16,
            height:DeviceUtil.isTablet ? 16.sp : 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          title: Text(title,style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),).tr(),
          trailing: titleValue != null ? Text(
            titleValue!,
            style: TextStyle(fontSize: DeviceUtil.isTablet ? 14.sp : 14),
          ) : RectangularCardShimmer(height: DeviceUtil.isTablet ? 30.h : 30,width: DeviceUtil.isTablet ? 20.w : 20,),
        ),
         Divider(
          height: 0.0,
          thickness: DeviceUtil.isTablet ? 1.w : 1,
        )
      ],
    );
  }
}
