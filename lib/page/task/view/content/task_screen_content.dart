import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/task/task.dart';
import 'package:onesthrm/page/task/view/content/all_task_list_complete_screen.dart';
import 'package:onesthrm/page/task/view/content/title_with_see_all_content.dart';
import 'package:onesthrm/res/nav_utail.dart';
import 'package:onesthrm/res/widgets/no_data_found_widget.dart';

class TaskScreenContent extends StatelessWidget {
  const TaskScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final staticsData = state.taskDashboardData?.data?.statistics;
        final taskListCollection = state.taskStatusListResponse?.data?.taskListCollection?.tasks;
        final completeTaskList = state.taskDashboardData?.data?.completeTasksCollection;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TaskDashboardCardList(staticsData: staticsData),

                TitleWithSeeAll(
                    context: context,
                    onTap: () {
                      NavUtil.navigateScreen(
                          context,
                          AllTaskListScreen(
                            bloc: context.read<TaskBloc>(),
                            taskCollection: taskListCollection,
                          ));
                    }, title: '',
                    child: const TaskStatusDropdown(),),

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
                    : const NoDataFoundWidget(),

                const SizedBox(
                  height: 12.0,
                ),

                ///complete task title
                TitleWithSeeAll(
                    context: context,
                    title: 'Completed Task',
                    onTap: () {
                      NavUtil.navigateScreen(
                          context,
                          AllTaskListCompleteScreen(
                            bloc: context.read<TaskBloc>(),
                            taskCompleteList: completeTaskList,
                          ));
                    }),

                const SizedBox(
                  height: 12.0,
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
                    : const NoDataFoundWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
