import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/break/bloc/break_bloc.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import '../../../res/const.dart';
import '../../app/global_state.dart';
import '../../attendance/content/animated_circular_button.dart';
import 'break_header.dart';

class BreakContent extends StatefulWidget {
  final HomeBloc homeBloc;

  const BreakContent({Key? key, required this.homeBloc}) : super(key: key);

  @override
  State<BreakContent> createState() => _BreakContentState();
}

class _BreakContentState extends State<BreakContent>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  final CustomTimerController controllerBreakTimer = CustomTimerController();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    WidgetsBinding.instance.addObserver(this);
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
    DashboardModel? dashboard = widget.homeBloc.state.dashboardModel;

    return BlocListener<BreakBloc, BreakState>(
      listenWhen: (oldState, newState) => oldState != newState,
      listener: (context, state) {
        if (state.isTimerStart) {
          controllerBreakTimer.start();
        } else {
          controllerBreakTimer.reset();
        }
        if(state.breakBack?.data?.status == 'break_out'){
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
                title: globalState.get(breakTime) != null ? 'Back' : 'Break',
                color: globalState.get(breakTime) != null ? colorDeepRed : colorPrimary,
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
              if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory !=
                  null)
                const SizedBox(
                  height: 20.0,
                ),
              if (dashboard?.data?.breakHistory?.breakHistory?.todayHistory !=
                  null)
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
                            color:
                                dashboard?.data?.config?.breakStatus?.status ==
                                        "break_in"
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
