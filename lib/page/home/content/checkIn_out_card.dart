import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/view/attendance_page.dart';
import 'package:onesthrm/page/attendance_selfie/attendance_selfie.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:qr_attendance/qr_attendance.dart';
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
    final user = context.read<AuthenticationBloc>().state.data;
    final baseUrl = globalState.get(companyUrl);

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () async{
            context.read<HomeBloc>().add(OnLocationRefresh(
                user: context.read<AuthenticationBloc>().state.data?.user,
                locationProvider: locationServiceProvider));

            // ///navigate into QR feature
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return BlocProvider.value(
            //       value: context.read<HomeBloc>(),
            //       child: QRAttendanceScreen(
            //         token: user!.user!.token!,
            //         baseUrl: baseUrl,
            //         callBackRoute: AttendancePage.route(
            //             homeBloc: context.read<HomeBloc>(),
            //             attendanceType: AttendanceType.qr),
            //       ));
            // }));

            await availableCameras().then(
                  (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: context.read<HomeBloc>(),
                      child: AttendanceSelfieScreen(cameras: value)),
                ),
              ),
            );
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
