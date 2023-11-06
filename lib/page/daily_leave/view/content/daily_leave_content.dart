import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../res/const.dart';
import '../../../../res/nav_utail.dart';
import '../../../attendance/content/animated_circular_button.dart';
import '../daily_create_page.dart';
import 'daily_leave_status_content.dart';
import 'daily_leave_status_widget.dart';

class DailyLeaveContent extends StatelessWidget {
  const DailyLeaveContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("daily_leave")),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          AnimatedCircularButton(
            onComplete: () {
              NavUtil.navigateScreen(context, const DailyCreatePage());
            },
            title: "Apply Daily Leave",
            color: colorPrimary,
          ),
          const DailyLeaveStatusContent()
        ],
      ),
    );
  }
}
