import 'package:flutter/material.dart';
import 'package:onesthrm/page/visit/view/content/visit_list_page.dart';

class VisitContent extends StatelessWidget {
  const VisitContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Visit"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                  Border(bottom: BorderSide(color: Colors.grey.shade400)),
                ),
                child: const TabBar(
                  isScrollable: false,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.green,
                  indicatorColor: Colors.green,
                  automaticIndicatorColorAdjustment: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: "My Visit",
                    ),
                    Tab(
                      text: "History",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body:  const Column(
            children: [
              Expanded(
                  child: TabBarView(
                    children: [
                      VisitListPage(),
                      Center(child: Text("History")),
                    ],
                  ))
            ],
          )),
    );
  }
}
