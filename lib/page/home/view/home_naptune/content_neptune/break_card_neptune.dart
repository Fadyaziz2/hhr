import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/view/break_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:core/core.dart';
import '../../../bloc/home_bloc.dart';

class BreakCardNeptune extends StatelessWidget {
  final Settings? settings;
  final LoginData? user;
  final DashboardModel? dashboardModel;

  const BreakCardNeptune(
      {super.key,
      required this.settings,
      required this.user,
      required this.dashboardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryBorderColor)),
      margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 18.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(BreakScreen.route(bloc: context.read<HomeBloc>()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: Row(
              children: [
                Expanded(
                  child: Lottie.asset(
                    'assets/images/tea_time.json',
                    height: 55.0.h,
                    width: 55.0.w,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          dashboardModel?.data?.config?.breakStatus?.status !=
                                  'break_out'
                              ? "you're_in_break".tr()
                              : "take_coffee".tr(),
                          style: TextStyle(
                              fontSize: 16.r,
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
