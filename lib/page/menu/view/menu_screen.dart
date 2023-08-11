import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/res/nav_utail.dart';
import '../../../res/const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../profile/view/profile_page.dart';
import '../content/menu_content_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final settings = context.read<HomeBloc>().state.settings;
    final homeData = context.watch<HomeBloc>().state.dashboardModel;
    final user = context.read<AuthenticationBloc>().state.data;

    return Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colorPrimary, colorPrimaryGradient])),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, ProfileScreen.route(user?.user?.id, settings));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20),
                      child: Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              imageUrl: "${user?.user?.avatar}",
                              placeholder: (context, url) => Center(
                                child: Image.asset(
                                    "assets/images/placeholder_image.png"),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.user?.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "VIEW PROFILE",
                                  style: TextStyle(
                                      fontSize: 14, color: colorPrimary),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (_scaffoldKey
                                    .currentState!.isEndDrawerOpen) {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                } else {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                }
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: colorPrimary,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: homeData?.data?.menus?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                    itemBuilder: (BuildContext context, int index) {

                      final menu =  homeData?.data?.menus?[index];

                      return menu != null ? MenuContentItem(
                          menu: menu,
                          onPressed: () {
                            getRoutSlag(context,menu.name);
                          }):const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            )));
  }
  getRoutSlag(context, String? name) {
    switch (name) {
      case 'Support':
        return NavUtil.navigateScreen(context, const SupportPage());
      case 'attendance':
        // return NavUtil.navigateScreen(
        //     context,
        //     const Attendance(
        //       navigationMenu: true,
        //     ));
      case 'notice':
        // return NavUtil.navigateScreen(context, const NoticeScreen());
      case 'expense':
        // return NavUtil.navigateScreen(context, const ExpenseList());
      case 'leave':
        // return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'approval':
        // return NavUtil.navigateScreen(
        //     context,
        //     const ApprovalScreen());
      case 'phonebook':
        // return NavUtil.navigateScreen(context, const PhonebookScreen());
      case 'conference':
        // return NavUtil.navigateScreen(context, const ConferenceScreen());
      case 'visit':
        // return NavUtil.navigateScreen(context, const VisitScreen());
      case 'meeting':
        // return NavUtil.navigateScreen(context, const MeetingScreen());
      case 'appointments':
        // return NavUtil.navigateScreen(context, const AppointmentScreen());
    // case 'face_attendance':
    //   return NavUtil.navigateScreen(
    //       context,
    //       const WebViewScreen(
    //           conferenceLink: "https://hrm.onesttech.com/faceattendance",appTitle: "Face Attendance",));
      case 'break':
        // return NavUtil.navigateScreen(
        //     context,
        //     NavUtil.navigateScreen(
        //         context,
        //         const BreakTime(
        //           diffTimeHome: '',
        //           hourHome: 0,
        //           minutesHome: 0,
        //           secondsHome: 0,
        //         )));
      case 'report':
        // return NavUtil.navigateScreen(context, const ReportScreen());
      case 'daily-leave':
        // return NavUtil.navigateScreen(context, const DailyLeave());
      case 'payroll':
        // return NavUtil.navigateScreen(context, const PayrollListScreen());
      case 'task':
        // return NavUtil.navigateScreen(context, const TaskDashboardScreen());
      default:
        return debugPrint('default');
    }
  }
}
