import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/nav_utail.dart';

import '../../task.dart';

class AllTaskListCompleteScreen extends StatelessWidget {
  const AllTaskListCompleteScreen(
      {Key? key, this.taskCompleteList, required this.bloc})
      : super(key: key);
  final List<TaskCompletionCollection>? taskCompleteList;
  final TaskBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Task'),
      ),
      body: taskCompleteList?.isNotEmpty == true
          ? ListView.builder(
              itemCount: taskCompleteList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final data = taskCompleteList?[index];
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
                    taskCompletionCollection: data,
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
