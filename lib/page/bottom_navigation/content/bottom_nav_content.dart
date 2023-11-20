import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/bloc/home_bloc.dart';
import 'package:onesthrm/page/leave/view/leave_page.dart';
import 'package:onesthrm/page/phonebook/view/phonebook_page.dart';
import 'package:onesthrm/page/all_natification/view/notification_screen.dart';
import 'package:upgrader/upgrader.dart';
import '../../../res/const.dart';
import '../../home/view/home_page.dart';
import '../../menu/view/menu_screen.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'bottom_nav_item.dart';

class BottomNavContent extends StatelessWidget {
  const BottomNavContent({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime timeBackPressed = DateTime.now();
    final selectedTab =
        context.select((BottomNavCubit cubit) => cubit.state.tab);

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
                    BottomNavItem(
                      icon: 'assets/home_icon/home.svg',
                      isSelected: selectedTab == BottomNavTab.home,
                      tab: BottomNavTab.home,
                    ),
                    BottomNavItem(
                      icon: 'assets/home_icon/attendance.svg',
                      isSelected: selectedTab == BottomNavTab.attendance,
                      tab: BottomNavTab.attendance,
                    ),
                    const SizedBox(width: 8.0),
                    BottomNavItem(
                      icon: 'assets/home_icon/leave.svg',
                      isSelected: selectedTab == BottomNavTab.leave,
                      tab: BottomNavTab.leave,
                    ),
                    BottomNavItem(
                      icon: 'assets/home_icon/notifications.svg',
                      isSelected: selectedTab == BottomNavTab.notification,
                      tab: BottomNavTab.notification,
                    ),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: selectedTab == BottomNavTab.menu
                  ? colorPrimary
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/home_icon/FavLogo.png',
                  color: selectedTab == BottomNavTab.menu
                      ? Colors.white
                      : colorPrimary,
                ),
              ),
              onPressed: () {
                context.read<BottomNavCubit>().setTab(BottomNavTab.menu);
                // myPage.jumpToPage(2);
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: IndexedStack(
            index: selectedTab.index,
            children: const [
              HomePage(),
              LeavePage(),
              MenuScreen(),
              SizedBox(),
              NotificationScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
