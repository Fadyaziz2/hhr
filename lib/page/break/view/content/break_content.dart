import 'package:core/core.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import 'package:onesthrm/page/break/view/content/break_history_content.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/page/internet_connectivity/bloc/bloc.dart';
import 'package:onesthrm/page/internet_connectivity/view/device_offline_view.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import 'package:onesthrm/res/widgets/device_util.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../res/const.dart';
import '../../../../res/dialogs/custom_dialogs.dart';
import '../../../attendance/content/animated_circular_button.dart';
import '../../../attendance/tab_content/tab_animated_circular_button.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import 'break_header.dart';
import 'break_report_screen.dart';

class BreakContent extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakContent({super.key, required this.homeBloc});

  @override
  State<BreakContent> createState() => BreakContentState();
}

class BreakContentState extends State<BreakContent>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  late CustomTimerController controllerBreakTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    controllerBreakTimer = CustomTimerController(
        vsync: this,
        begin: Duration(
            hours: int.parse(globalState.get(hour) ?? '0'),
            minutes: int.parse(globalState.get(min) ?? '0'),
            seconds: int.parse(globalState.get(sec) ?? '0')),
        end: const Duration(days: 1));

    if (globalState.get(breakStatus) == 'break_in') {
      controllerBreakTimer.start();
    } else {
      ///current time of milliseconds
      SharedUtil.deleteKey(breakTime);
      controllerBreakTimer.reset();
    }
  }

  @override
  void dispose() {
    controllerBreakTimer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print("resumed");
        }
        if (globalState.get(breakStatus) == 'break_in') {
          controllerBreakTimer.start();
        } else {
          controllerBreakTimer.reset();
        }
        break;
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print("inactive");
        }
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("paused");
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("detached");
        }
        break;
      case AppLifecycleState.hidden:
        if (kDebugMode) {
          print("hidden");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dashboard = widget.homeBloc.state.dashboardModel;
    final internetStatus = context.read<InternetBloc>().state.status;

    if (dashboard != null) {
      context.read<BreakBloc>().add(OnInitialHistoryEvent(
          breaks: dashboard.data!.breakHistory?.breakHistory?.todayHistory));
    }
    return DeviceOfflineView(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(DeviceUtil.isTablet ? 80.0 : 50),
          child: AppBar(
            iconTheme: IconThemeData(
                size: DeviceUtil.isTablet ? 40 : 30, color: Colors.white),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF00CCFF), colorPrimary],
                    begin: FractionalOffset(3.0, 0.0),
                    end: FractionalOffset(0.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            title: Text("break_time",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: appBarColor,
                        fontSize: 16.r))
                .tr(),
            actions: [
              InkWell(
                onTap: () {
                  NavUtil.navigateScreen(
                      context,
                      BlocProvider.value(
                          value: context.read<BreakBloc>(),
                          child: const BreakReportScreen()));
                },
                child: Row(
                  children: [
                    Lottie.asset(
                      'assets/images/ic_report_lottie.json',
                      height: DeviceUtil.isTablet ? 40.h : 40,
                      width: DeviceUtil.isTablet ? 40.w : 40,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: BlocListener<BreakBloc, BreakState>(
          listenWhen: (oldState, newState) =>
              oldState.isTimerStart != newState.isTimerStart,
          listener: (context, state) {
            if (globalState.get(breakStatus) == 'break_in') {
              controllerBreakTimer.start();

              ///current time of milliseconds
              SharedUtil.setValue(
                  breakTime, '${DateTime.now().millisecondsSinceEpoch}');
            } else {
              controllerBreakTimer.reset();

              ///current time of milliseconds
              SharedUtil.deleteKey(breakTime);
            }

            ///show message from apis weather break/back
            ///success or failure
            if (state.breakBack?.message != null) {
              showLoginDialog(
                  context: context,
                  message: '${user?.user?.name}',
                  body: '${state.breakBack?.message}',
                  isSuccess: state.status == NetworkStatus.success &&
                      state.breakBack?.result == true);
            }

            ///if break / back success then home api call again
            ///for update break status in parent widget
            if (state.status == NetworkStatus.success) {
              widget.homeBloc.add(LoadHomeData());
            }
          },
          child: BlocBuilder<BreakBloc, BreakState>(builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  BreakHeader(
                      timerController: controllerBreakTimer,
                      dashboardModel: dashboard),
                  state.status == NetworkStatus.loading
                      ? Shimmer.fromColors(
                          baseColor: const Color(0xFFE8E8E8),
                          highlightColor: Colors.white,
                          child: Container(
                              height: 184,
                              width: 184,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8E8E8),
                                borderRadius: BorderRadius.circular(
                                    100), // radius of 10// green as background color
                              )),
                        )
                      : DeviceUtil.isTablet
                          ? TabAnimatedCircularButton(
                              title: globalState.get(breakStatus) == 'break_in'
                                  ? 'Back'.tr()
                                  : 'Break'.tr(),
                              color: globalState.get(breakStatus) == 'break_in'
                                  ? colorDeepRed
                                  : colorPrimary,
                              onComplete: () {
                                if (internetStatus == InternetStatus.online) {
                                  context
                                      .read<BreakBloc>()
                                      .add(OnBreakBackEvent());
                                }
                              },
                            )
                          : AnimatedCircularButton(
                              title: globalState.get(breakStatus) == 'break_in'
                                  ? 'Back'.tr()
                                  : 'Break'.tr(),
                              color: globalState.get(breakStatus) == 'break_in'
                                  ? colorDeepRed
                                  : colorPrimary,
                              onComplete: () {
                                if (internetStatus == InternetStatus.online) {
                                  context
                                      .read<BreakBloc>()
                                      .add(OnBreakBackEvent());
                                }
                              },
                            ),
                  BreakHistoryContent(state: state, dashboard: dashboard)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
