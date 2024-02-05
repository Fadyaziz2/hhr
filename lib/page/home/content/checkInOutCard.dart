import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance_qr/attendance_qr.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../view/content/home_content.dart';

class CheckInOutCard extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const CheckInOutCard(
      {super.key,
      required this.settings,
      required this.user,
      required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () {
            context.read<HomeBloc>().add(OnLocationRefresh(
                user: context.read<AuthenticationBloc>().state.data?.user,
                locationProvider: locationServiceProvider));
            // Navigator.push(context,
            //     AttendancePage.route(homeBloc: context.read<HomeBloc>()));
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return const QRAttendanceScreen();
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    dashboardModel?.data?.attendanceData?.checkIn == false
                        ? 'assets/home_icon/in.svg'
                        : 'assets/home_icon/out.svg',
                    height: 40.h,
                    width: 40.w,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          dashboardModel?.data?.attendanceData?.id == null
                              ? "start_time".tr()
                              : "done_for_today".tr(),
                          style: TextStyle(
                              fontSize: 16.r,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              letterSpacing: 0.5)),
                      Text(
                        dashboardModel?.data?.attendanceData?.id == null
                            ? "check_in".tr()
                            : "check_out".tr(),
                        style: TextStyle(
                            color: colorPrimary,
                            fontSize: 16.r,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
