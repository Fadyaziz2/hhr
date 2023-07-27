import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import '../../../res/const.dart';
import '../../../res/date_utils.dart';
import '../../../res/dialogs/custom_dialogs.dart';
import '../../app/global_state.dart';
import '../../attendance/content/animated_circular_button.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'break_header.dart';

class BreakContent extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakContent({Key? key, required this.homeBloc}) : super(key: key);

  @override
  State<BreakContent> createState() => BreakContentState();
}

class BreakContentState extends State<BreakContent>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  late CustomTimerController controllerBreakTimer;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

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
      controllerBreakTimer.reset();
    }
  }

  @override
  void dispose() {
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
        // Handle this case
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print("inactive");
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print("detached");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.data;
    final dashboard = widget.homeBloc.state.dashboardModel;

    return BlocListener<BreakBloc, BreakState>(
      listenWhen: (oldState, newState) => oldState.isTimerStart != newState.isTimerStart,
      listener: (context, state) {
        if (globalState.get(breakStatus) == 'break_in') {
          controllerBreakTimer.start();
          ///current time of milliseconds
          SharedUtil.setValue(breakTime, '${now.millisecondsSinceEpoch}');
        } else {
          controllerBreakTimer.reset();
          ///current time of milliseconds
          SharedUtil.deleteKey(breakTime);
        }

        if (state.breakBack?.message != null) {
          showLoginDialog(
              context: context,
              message: '${user?.user?.name}',
              body: '${state.breakBack?.message}',
              isSuccess: state.status == NetworkStatus.success && state.breakBack?.result == true);
        }

        if (state.status == NetworkStatus.success) {
          widget.homeBloc.add(LoadHomeData());
        }
      },
      child: BlocBuilder<BreakBloc, BreakState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20.0),
              BreakHeader(
                timerController: controllerBreakTimer,
                dashboardModel: dashboard,
              ),
              AnimatedCircularButton(
                title: globalState.get(breakStatus) == 'break_in'
                    ? 'Back'
                    : 'Break',
                color: globalState.get(breakStatus) == 'break_in'
                    ? colorDeepRed
                    : colorPrimary,
                onComplete: () {
                  context.read<BreakBloc>().add(OnBreakBackEvent());
                },
              ),
              if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory != null)
                const Text(
                  "Last Breaks",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              if (state.breakBack?.data?.breakBackHistory?.todayHistory != null)
                const SizedBox(height: 20.0),
              if (state.breakBack?.data?.breakBackHistory?.todayHistory != null)
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TodayHistory? todayHistory = state.breakBack?.data?.breakBackHistory?.todayHistory?.elementAt(index);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              todayHistory?.breakTimeDuration ?? "",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            width: 3,
                            color: globalState.get(breakStatus) == 'break_in'
                                ? const Color(0xFFE8356C)
                                : colorPrimary,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todayHistory?.reason ?? "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(todayHistory?.breakBackTime ?? ""),
                            ],
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: dashboard?.data?.breakHistory?.breakHistory
                        ?.todayHistory!.length ??
                        0),
              if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory != null)
                const SizedBox(height: 20.0),
              if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory != null && state.breakBack?.data?.breakBackHistory?.todayHistory == null)
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TodayHistory? todayHistory = dashboard
                          ?.data?.breakHistory?.breakHistory?.todayHistory!
                          .elementAt(index);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              todayHistory?.breakTimeDuration ?? "",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            width: 3,
                            color: globalState.get(breakStatus) == 'break_in'
                                ? const Color(0xFFE8356C)
                                : colorPrimary,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todayHistory?.reason ?? "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(todayHistory?.breakBackTime ?? ""),
                            ],
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: dashboard?.data?.breakHistory?.breakHistory
                            ?.todayHistory!.length ??
                        0)
            ],
          ),
        );
      }),
    );
  }
}
