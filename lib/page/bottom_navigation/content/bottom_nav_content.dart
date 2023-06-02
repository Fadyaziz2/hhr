import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upgrader/upgrader.dart';
import '../../../res/const.dart';
import '../../home/view/home_page.dart';
import '../bloc/bottom_nav_cubit.dart';
import 'bottom_nav_item.dart';

class BottomNavContent extends StatelessWidget {
  const BottomNavContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final PageController myPage = PageController(initialPage: 0);
    DateTime timeBackPressed = DateTime.now();

    final selectedTab = context.select((BottomNavCubit cubit) => cubit.state.tab);

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
                    BottomNavItem(icon: 'assets/home_icon/home.svg', isSelected: selectedTab  == BottomNavTab.home, tab: BottomNavTab.home,),
                    BottomNavItem(icon: 'assets/home_icon/attendance.svg', isSelected: selectedTab  == BottomNavTab.attendance, tab: BottomNavTab.attendance,),
                    const SizedBox(width: 8.0),
                    BottomNavItem(icon: 'assets/home_icon/leave.svg', isSelected: selectedTab  == BottomNavTab.leave, tab: BottomNavTab.leave,),
                    BottomNavItem(icon: 'assets/home_icon/notifications.svg', isSelected: selectedTab  == BottomNavTab.notification, tab: BottomNavTab.notification,),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              child:
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
