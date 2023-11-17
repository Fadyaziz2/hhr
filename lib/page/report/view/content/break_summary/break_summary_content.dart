import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onesthrm/res/nav_utail.dart';

import 'break_report_list.dart';
import 'break_report_search.dart';

class BreakSummaryContent extends StatelessWidget {
  const BreakSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Card(
                child: ListTile(
                  onTap: () => NavUtil.navigateScreen(
                    context,
                    const BreakReportList(),
                  ),
                  leading: ClipOval(
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png",
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  title: const Text(
                    'Bijoy Ghosh',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('Admin',
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  trailing: const Text(
                    '00:05:00',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            );
          },
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Card(
            elevation: 4,
            color: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                NavUtil.navigateScreen(context, const BreakReportSearch());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      tr('search_all_break_report'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
