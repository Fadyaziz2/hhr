import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/const.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'break_report_list.dart';
import 'break_summary_content.dart';

class BreakReportSummary extends StatelessWidget {
  const BreakReportSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF00CCFF),
                    colorPrimary,
                  ],
                  begin: FractionalOffset(3.0, 0.0),
                  end: FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: Text(
            tr('break_summary'),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: appBarColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  NavUtil.navigateScreen(
                    context,
                    const BreakReportList(),
                  );
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        body: const BreakSummaryContent());
  }
}
