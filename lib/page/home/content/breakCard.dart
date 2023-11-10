import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/view/break_page.dart';
import 'package:user_repository/user_repository.dart';
import '../../../res/const.dart';
import '../bloc/home_bloc.dart';

class BreakCard extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const BreakCard(
      {Key? key,
      required this.settings,
      required this.user,
      required this.dashboardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(BreakScreen.route(
                homeBloc: context.read<HomeBloc>(),
                dashboardModel: dashboardModel));
          },
          child: Row(
            children: [
              Expanded(
                child: Lottie.asset(
                  'assets/images/tea_time.json',
                  height: 60.0.h,
                  width: 60.0.w,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        dashboardModel?.data?.config?.breakStatus?.status !=
                                'break_out'
                            ? "You're in break"
                            : "take_coffee".tr(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.5)),
                    // SizedBox(height: 10.h),
                    Text(
                      dashboardModel?.data?.config?.breakStatus?.status !=
                              'break_out'
                          ? '${dashboardModel?.data?.config?.breakStatus?.breakTime}'
                          : 'break'.tr(),
                      style: TextStyle(
                          color: colorPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
