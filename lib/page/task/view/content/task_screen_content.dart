import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/menu/view/menu_screen.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/page/task/view/content/all_task_list_complete_screen.dart';
import 'package:onesthrm/res/nav_utail.dart';

class TaskScreenContent extends StatelessWidget {
  const TaskScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final staticsData = state.taskDashboardData?.data?.statistics;
        final taskListCollection =
            state.taskStatusListResponse?.data?.taskListCollection?.tasks;
        final completeTaskList =
            state.taskDashboardData?.data?.completeTasksCollection;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TaskDashboardCardList(staticsData: staticsData),

                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TaskStatusDropdown(),
                      InkWell(
                        onTap: () {
                          NavUtil.navigateScreen(
                              context,
                              AllTaskListScreen(
                                bloc: context.read<TaskBloc>(),
                                taskCollection: taskListCollection,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            "See All",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                taskListCollection?.isNotEmpty == true
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: taskListCollection?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = taskListCollection?[index];
                          return TaskListCard(
                            onTap: () {
                              NavUtil.navigateScreen(
                                context,
                                TaskScreenDetails(
                                  bloc: context.read<TaskBloc>(),
                                  taskId: data!.id.toString(),
                                ),
                              );
                            },
                            userCount: data?.usersCount,
                            taskListData: data,
                            taskName: data?.title,
                            tapButtonColor: const Color(0xFF00a8e6),
                            taskStartDate: data?.dateRange,
                          );
                        },
                      )
                    : buildListDataNotFound(context),

                const SizedBox(
                  height: 12.0,
                ),

                ///complete task title
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Completed Task",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                          InkWell(
                            onTap: () {
                              NavUtil.navigateScreen(
                                  context,
                                  AllTaskListCompleteScreen(
                                    bloc: context.read<TaskBloc>(),
                                    taskCompleteList: completeTaskList,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Text(
                                "See All",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          )
                        ],
                      ),
                      completeTaskList?.isNotEmpty == true
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: completeTaskList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                final data = completeTaskList?[index];
                                return TaskListCard(
                                  onTap: () {
                                    NavUtil.navigateScreen(
                                      context,
                                      TaskScreenDetails(
                                        bloc: context.read<TaskBloc>(),
                                        taskId: data!.id.toString(),
                                      ),
                                    );
                                  },
                                  userCount: data?.usersCount,
                                  taskCompletionCollection: data,
                                  taskName: data?.title,
                                  tapButtonColor: const Color(0xFF00a8e6),
                                  taskStartDate: data?.dateRange,
                                );
                              },
                            )
                          : buildListDataNotFound(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildListDataNotFound(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.white),
      child: const Center(
          child: Text(
        "No Task Available",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
