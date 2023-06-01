import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:upgrader/upgrader.dart';

import '../../res/const.dart';

class BottomNavigationPage extends StatefulWidget {
  final int? bottomNavigationIndex;

  const BottomNavigationPage({Key? key, this.bottomNavigationIndex})
      : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const BottomNavigationPage());
  }

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  @override
  Widget build(BuildContext context) {

    final PageController myPage = PageController(initialPage: 0);
    DateTime timeBackPressed = DateTime.now();

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
                        color: const Color(0xFF555555),
                      ),
                      onPressed: () {
                        setState(() {
                          myPage.jumpToPage(0);
                        });
                        // provider.jumpPage(0);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/attendance.svg',
                          height: 20,
                          color: const Color(0xFF555555),
                        ),
                        onPressed: () {
                          setState(() {
                            myPage.jumpToPage(1);
                          });
                          // provider.jumpPage(1);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/leave.svg',
                          height: 20,
                          color: colorPrimary,
                        ),
                        onPressed: () {
                          // provider.jumpPage(3);
                          setState(() {
                            myPage.jumpToPage(3);
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/home_icon/notifications.svg',
                        height:20,
                        color: const Color(0xFF555555),
                      ),
                      onPressed: () {
                        // provider.jumpPage(4);
                        setState(() {
                          myPage.jumpToPage(4);
                        });
                      },
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
