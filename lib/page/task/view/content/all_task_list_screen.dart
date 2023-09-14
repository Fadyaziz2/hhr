import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../task.dart';

class AllTaskListScreen extends StatelessWidget {
  const AllTaskListScreen({Key? key, this.taskCollection, required this.bloc})
      : super(key: key);
  final List<TaskCollection>? taskCollection;
  final TaskBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Task'),
      ),
      body: taskCollection?.isNotEmpty == true
          ? ListView.builder(
              itemCount: taskCollection?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final data = taskCollection?[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TaskListCard(
                    onTap: () {
                      NavUtil.navigateScreen(
                        context,
                        TaskScreenDetails(
                          bloc: bloc,
                          taskId: data!.id.toString(),
                        ),
                      );
                    },
                    userCount: data?.usersCount,
                    taskListData: data,
                    taskName: data?.title,
                    tapButtonColor: const Color(0xFF00a8e6),
                    taskStartDate: data?.dateRange,
                  ),
                );
              },
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/images/no_data_found.json',
                      repeat: false, height: 200),
                  const Text('No Results'),
                ],
              ),
            ),
    );
  }
}
