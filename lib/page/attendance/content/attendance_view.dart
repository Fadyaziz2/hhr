import 'package:face/face_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/content/show_current_location.dart';
import 'package:onesthrm/page/attendance/content/show_current_time.dart';
import 'package:onesthrm/page/attendance_report/view/attendance_report_page.dart';
import 'package:onesthrm/res/dialogs/custom_dialogs.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import 'animated_circular_button.dart';
import 'check_in_check_out_time.dart';

class AttendanceView extends StatefulWidget {
  final HomeBloc homeBloc;

  const AttendanceView({Key? key, required this.homeBloc}) : super(key: key);

  @override
  State<AttendanceView> createState() => _AttendanceState();
}

class _AttendanceState extends State<AttendanceView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  ///set condition here weather face checking enable or disable
  ///if enabled then we have to create faceSDK service instance
  FaceServiceImpl faceService = FaceServiceImpl();

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3), animationBehavior: AnimationBehavior.preserve);
    ///set condition here weather face checking enable or disable
    ///fetch face date from local cache
    SharedUtil.getValue(userFaceData).then((registeredFaceData){
      faceService.captureFromFaceApi(
          isRegistered: registeredFaceData != null,
          regImage: registeredFaceData,
          onCaptured: (faceData) {
            debugPrint('faceData $faceData');
            if(faceData.length > 20){
              SharedUtil.setValue(userFaceData, faceData);
            }
          },
          isSimilar: (isSimilar) {
            debugPrint('isSimilar $isSimilar');
            if(isSimilar){
              if(widget.homeBloc.state.dashboardModel != null) {
                context.read<AttendanceBloc>().add(OnAttendance(homeData: widget.homeBloc.state.dashboardModel!));
              }else{
                debugPrint('dashboardModel is null\n you have to check api');
              }
            }
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final homeData = widget.homeBloc.state.dashboardModel;
    final settings = widget.homeBloc.state.settings;

    return BlocListener<AttendanceBloc, AttendanceState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.checkData?.message != null) {
          showLoginDialog(
              context: context,
              message: '${user?.user?.name}',
              body: '${state.checkData?.message}',
              isSuccess: state.checkData?.checkInOut != null ? true : false);
        }
        if (state.status == NetworkStatus.success) {
          widget.homeBloc.add(LoadHomeData());
        }
      },
      child: BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Attendance'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          AttendanceReportPage.route(
                              attendanceBloc: context.read<AttendanceBloc>(),
                              settings: settings!));
                    },
                    icon: const Icon(Icons.bug_report_outlined))
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
                          ? "Check In"
                          : "Check Out",
                      color: globalState.get(attendanceId) == null
                          ? colorPrimary
                          : colorDeepRed,
                    ),

                  const SizedBox(
                    height: 35,
                  ),

                  /// Show Check In Check Out time
                  if (homeData != null)
                    CheckInCheckOutTime(
                      homeData: homeData,
                    ),
                  const SizedBox(height: 70.0)
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
    super.dispose();
  }
}
