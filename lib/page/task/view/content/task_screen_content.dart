import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/task/model/status_model.dart';
import 'package:onesthrm/page/task/task.dart';

class TaskScreenContent extends StatelessWidget {
  const TaskScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final staticsData = state.taskDashboardData?.data?.statistics;
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TaskDashboardCard(
                  customPainter: TotalTaskCustomPainter(),
                  title: staticsData?[0].text ?? '',
                  count: '${staticsData?[0].count ?? ''}',
                  titleAsset: "assets/task/task.png",
                  titleColor: const Color(0xffD8808F),
                ),
                const SizedBox(
                  width: 13,
                ),
                TaskDashboardCard(
                  customPainter: TotalCompleteTaskCustomPainter(),
                  title: staticsData?[1].text ?? '',
                  count: '${staticsData?[1].count ?? ''}',
                  titleAsset: "assets/task/complete_task.png",
                  titleColor: const Color(0xff80C090),
                ),
              ],
            ),
            Row(
              children: [
                TaskDashboardCard(
                  customPainter: TotalTaskInProgressCustomPainter(),
                  title: staticsData?[2].text ?? '',
                  count: '${staticsData?[2].count ?? ''}',
                  titleAsset: "assets/task/task_in_progress.png",
                  titleColor: const Color(0xffD3B980),
                ),
                const SizedBox(
                  width: 13,
                ),
                TaskDashboardCard(
                  // ontap: () => NavUtil.navigateScreen(
                  //     context,
                  //     TaskListScreen(
                  //       taskId: statistics?[3].status,
                  //     )),
                  customPainter: TotalTaskInReviewCustomPainter(),
                  title: staticsData?[3].text ?? '',
                  count: '${staticsData?[3].count ?? ''}',
                  titleAsset: "assets/task/task_in_review.png",
                  titleColor: const Color(0xff80BBC3),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10),
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      // boxShadow: const [
                      //   BoxShadow(color: Colors.grey, spreadRadius: 1),
                      // ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<StatusModel>(
                        isExpanded: true,
                        hint: const Text(
                          "In Progress",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: selectedVlaue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          size: 20,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (StatusModel? newValue) {
                          // setState(() {
                          //   selectedVlaue = newValue!;
                          //   provider.setSelectStatusValue(
                          //       newValue.id!);
                          // });
                        },
                        items: statusList
                            .map<DropdownMenuItem<StatusModel>>(
                                (StatusModel value) {
                              return DropdownMenuItem<StatusModel>(
                                value: value,
                                child: Text(
                                  value.title ?? '',
                                  style:
                                  const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // NavUtil.navigateScreen(
                      //     context,
                      //     TaskInProgressListScreen(
                      //       statusId:
                      //       provider.selectedStatusVlaue,
                      //     ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: AppColors.colorPrimary),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "See All",
                        style: TextStyle(
                            // color: AppColors.colorPrimary,
                            fontSize: 14.0),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Expanded(
                child: ListView.builder(
              itemCount: state.taskStatusListResponse?.data?.taskListCollection
                      ?.tasks?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                final data = state.taskStatusListResponse?.data
                    ?.taskListCollection?.tasks?[index];
                return Text(data?.title ?? '');
              },
            )),
            ///complete task title
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: Column(
                children: [
                  //title and see all
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed Task",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      InkWell(
                        onTap: () {
                          // NavUtil.navigateScreen(context,
                          //     const CompleteTaskListScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 1, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                            BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "See All",
                            style: TextStyle(
                                fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
