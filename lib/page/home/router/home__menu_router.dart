import 'package:flutter/cupertino.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/appointment/appoinment_list/view/appointment_screen.dart';
import 'package:onesthrm/page/home/view/content/home_content_shimmer.dart';
import 'package:onesthrm/page/home/view/content/home_earth_content.dart';
import 'package:onesthrm/page/home/view/home_mars/home_mars_page.dart';
import 'package:onesthrm/page/home/view/home_naptune/content_neptune/home_neptune_content.dart';
import 'package:onesthrm/page/meeting/view/meeting_page.dart';
import 'package:onesthrm/page/support/view/support_page.dart';
import 'package:onesthrm/page/visit/view/visit_page.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

Widget chooseTheme() {
  final name = globalState.get(dashboardStyleId);
  switch (name) {
    case 'earth':
      return const HomeEarthContent();
    case 'neptune':
      return const HomeNeptuneContent();
    case 'mars':
      return const HomeMars();
    default:
      return const HomeContentShimmer();
  }
}
void routeSlug(slugName, context) {
  switch (slugName) {
    case 'support':
      NavUtil.navigateScreen(context, const SupportPage());
      break;
    case 'support_ticket':
      NavUtil.navigateScreen(context, const SupportPage());
      break;
    case 'visit':
      NavUtil.navigateScreen(context, const VisitPage());
      break;
    case 'appointment':
      NavUtil.navigateScreen(context, const AppointmentScreen());
      break;
    case 'meeting':
      NavUtil.navigateScreen(context, const MeetingPage());
      break;
    default:
      return debugPrint('default');
  }
}





