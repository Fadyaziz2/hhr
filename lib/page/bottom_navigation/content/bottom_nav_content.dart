import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upgrader/upgrader.dart';
import '../../../res/const.dart';
import '../../home/view/home_page.dart';
import '../bloc/bottom_nav_cubit.dart';

class BottomNavContent extends StatelessWidget {
  const BottomNavContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final PageController myPage = PageController(initialPage: 0);
    DateTime timeBackPressed = DateTime.now();

    final selectedTab = context.select((BottomNabCubit cubit) => cubit.state.tab);

    return UpgradeAlert(
      upgrader: Upgrader(
        debugLogging: true,
        durationUntilAlertAgain: const Duration(hours: 1),
        countryCode: 'US',
        shouldPopScope: () => true,
      ),
      child: WillPopScope(
        onWillPop: () async {
          final differences = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differences >= const Duration(seconds: 2)) {
            String msg = "Press the back button to exit";
            Fluttertoast.showToast(
              msg: msg,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            SystemNavigator.pop();
            return true;
          }
        },
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Container(
            color: Colors.transparent,
            child: BottomAppBar(
                elevation: 4,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/home_icon/home.svg',
                        height: 20,
                        color: selectedTab  == BottomNavTab.home ? colorPrimary: const Color(0xFF555555),
                      ),
                      onPressed: () => context.read<BottomNabCubit>().setTab(BottomNavTab.home),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/attendance.svg',
                          height: 20,
                          color: selectedTab  == BottomNavTab.attendance ? colorPrimary: const Color(0xFF555555),
                        ),
                        onPressed: () => context.read<BottomNabCubit>().setTab(BottomNavTab.attendance),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/leave.svg',
                          height: 20,
                          color: selectedTab  == BottomNavTab.leave ? colorPrimary: const Color(0xFF555555),
                        ),
                        onPressed: () => context.read<BottomNabCubit>().setTab(BottomNavTab.leave),
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/home_icon/notifications.svg',
                        height:20,
                        color: selectedTab  == BottomNavTab.notification ? colorPrimary: const Color(0xFF555555),
                      ),
                      onPressed: () => context.read<BottomNabCubit>().setTab(BottomNavTab.notification),
                    ),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              child:
              // const Icon(Icons.menu),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/home_icon/FavLogo.png',
                  color: colorPrimary,
                ),
              ),
              onPressed: () {

              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: myPage,
            onPageChanged: (index) {

            },
            children:  const [
              HomePage(),
              HomePage(),
              HomePage(),
              HomePage(),
            ],
          ),
        ),
      ),
    );
  }
}
