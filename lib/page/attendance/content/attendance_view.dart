import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/content/show_current_location.dart';
import 'package:onesthrm/page/attendance/content/show_current_time.dart';
import 'package:onesthrm/page/attendance_report/view/attendance_report_page.dart';
import 'package:onesthrm/res/dialogs/custom_dialogs.dart';
import 'package:onesthrm/res/enum.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/view/content/home_content.dart';
import 'animated_circular_button.dart';
import 'check_in_check_out_time.dart';

class AttendanceView extends StatefulWidget {

  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceView>
    with TickerProviderStateMixin {
  late AnimationController controller;

  ///set condition here weather face checking enable or disable
  ///if enabled then we have to create faceSDK service instance
  // FaceServiceImpl faceService = FaceServiceImpl();

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        animationBehavior: AnimationBehavior.preserve);

    ///set condition here weather face checking enable or disable
    ///fetch face date from local cache
    // SharedUtil.getValue(userFaceData).then((registeredFaceData) {
    //   faceService.captureFromFaceApi(
    //       isRegistered: registeredFaceData != null,
    //       regImage: registeredFaceData,
    //       onCaptured: (faceData) {
    //         debugPrint('faceData $faceData');
    //         if (faceData.length > 20) {
    //           SharedUtil.setValue(userFaceData, faceData);
    //         }
    //       },
    //       isSimilar: (isSimilar) {
    //         debugPrint('isSimilar $isSimilar');
    //         if (isSimilar) {
    //           if (widget.homeBloc.state.dashboardModel != null) {
    //             context.read<AttendanceBloc>().add(OnAttendance(
    //                 homeData: widget.homeBloc.state.dashboardModel!));
    //           } else {
    //             debugPrint('dashboardModel is null\n you have to check api');
    //           }
    //         }
    //       });
    // });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final homeBloc = context.read<HomeBloc>();
    final homeData = homeBloc.state.dashboardModel;
    final settings = homeBloc.state.settings;

    if (user?.user != null) {
      locationServiceProvider.getCurrentLocationStream(uid: user!.user!.id!, metaClubApiClient: MetaClubApiClient(token: user.user!.token!));
    }

    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.checkData?.message != null && state.actionStatus == ActionStatus.checkInOut) {
          showLoginDialog(
              context: context,
              message: '${user?.user?.name}',
              body: '${state.checkData?.message}',
              isSuccess: state.checkData?.checkInOut != null ? true : false);
        }
        if (state.status == NetworkStatus.success) {
          homeBloc.add(LoadHomeData());
        }
      },
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('attendance'.tr()),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                            Navigator.push(
                                context,
                                AttendanceReportPage.route(
                                    attendanceBloc: context.read<AttendanceBloc>(),
                                     settings: settings!));
                    },
                    child: Lottie.asset(
                      'assets/images/ic_report_lottie.json',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: ListView(
                children: [
                  /// Show Current Location and Remote mode ......
                  if (homeData != null)
                    ShowCurrentLocation(
                      homeData: homeData,
                    ),

                  /// Show Current time .......
                  if (homeData != null) ShowCurrentTime(homeData: homeData),

                  if (homeData != null)
                    AnimatedCircularButton(
                      onComplete: () {
                        context
                            .read<AttendanceBloc>()
                            .add(OnAttendance(homeData: homeData));
                      },
                      isCheckedIn: homeData.data?.attendanceData?.id != null,
                      title: globalState.get(attendanceId) == null
                          ? "check_in".tr()
                          : "check_out".tr(),
                      color: globalState.get(attendanceId) == null
                          ? colorPrimary
                          : colorDeepRed,
                    ),

                  SizedBox(
                    height: 35.h,
                  ),

                  /// Show Check In Check Out time
                  if (homeData != null)
                    CheckInCheckOutTime(
                      homeData: homeData,
                    ),
                  SizedBox(height: 70.0.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // faceService.deInit();
    locationServiceProvider.disposePlaceController();
    super.dispose();
  }
}
