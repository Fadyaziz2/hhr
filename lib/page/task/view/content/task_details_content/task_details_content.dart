import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/task/task.dart';

class TaskScreenDetails extends StatelessWidget {
  const TaskScreenDetails({Key? key, this.bloc, required this.taskId})
      : super(key: key);
  final TaskBloc? bloc;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: FutureBuilder(
        future: bloc?.onTaskDetailsDataRequest(taskId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.data?.taskDetails;
            final members = snapshot.data?.data?.members;

            if (data != null) {
              bloc?.add(
                  TaskDetailsStatusRadioValueSet(statusId: data.statusId!));

              bloc?.add(TaskDetailsSliderValueSet(
                  sliderValue: double.parse(data.progress.toString())));

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitleAndValue(
                          title: 'Task Name', data: data.title ?? ''),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Description ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        data.description ?? "",
                        maxLines: 5,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: Color(0xff8A8A8A), fontSize: 14.0),
                      ),
                      buildTitleAndValue(
                          title: "Priority", data: data.priority),
                      buildTitleAndValue(
                        title: "Task Supervisor",
                        data: data.supervisor ?? "",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Deadline",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                          data.status != "Completed"
                              ? InkWell(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (_) => buildAlertDialog(
                                          data, bloc!, context),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          // color: AppColors.colorPrimary,
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text(
                                      "Update Status",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.0),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    const Text(
                                      "Task Complete",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Image.asset(
                                      "assets/task/check.png",
                                      height: 24.0,
                                      width: 24.0,
                                    )
                                  ],
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/task/light_calender.png",
                            height: 44.0,
                            width: 44.0,
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Text(
                            data.startDate ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Image.asset(
                            "assets/task/light_calender.png",
                            height: 44.0,
                            width: 44.0,
                          ),
                          const SizedBox(
                            width: 23.0,
                          ),
                          Text(
                            data.endDate ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ProgressIndicatorWithPercentage(
                        percentageActiveColor: Colors.blue,
                        percentageDisableColor: const Color(0xffC9C9C9),
                        activeContainerWidth: ((screenWidth - 80.0) *
                                double.parse('${data.progress ?? 0}')) /
                            100,
                        deActivateContainerWidth: (screenWidth - 80.0) -
                            ((screenWidth - 85.0) *
                                    double.parse('${data.progress ?? 0}')) /
                                100,
                        containerHeight: 12.0,
                        percentage: "${data.progress ?? 0}%",
                        percentageTextHeight: 16.0,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Text(
                        "Assignee",
                        textAlign: TextAlign.justify,
                        style:
                            TextStyle(color: Color(0xff8A8A8A), fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: members?.isNotEmpty == true
                            ? members!
                                .map((e) => Stack(
                                      children: [
                                        Positioned(
                                            child: InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AssignAlertDialog(
                                                assignMembers: e,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 36.0,
                                            width: 36.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(e.avatar!),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.circle),
                                          ),
                                        ))
                                      ],
                                    ))
                                .toList()
                            : [],
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  AlertDialog buildAlertDialog(
      TaskDetails? data, TaskBloc bloc, BuildContext context) {
    return AlertDialog(
      title: Text("${data?.title} "),
      content: StatefulBuilder(
        builder: (context, void Function(void Function()) setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Your Task Status"),
              RadioListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text("Not Started"),
                value: 24,
                groupValue: bloc.state.taskDetailsRadioValueSelect,
                onChanged: (int? value) {
                  setState(() {
                    bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                  });
                },
              ),
              RadioListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text("On Hold"),
                value: 25,
                groupValue: bloc.state.taskDetailsRadioValueSelect,
                onChanged: (int? value) {
                  setState(() {
                    bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                  });
                },
              ),
              RadioListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text("In Progress"),
                value: 26,
                groupValue: bloc.state.taskDetailsRadioValueSelect,
                onChanged: (int? value) {
                  setState(() {
                    bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                  });
                },
              ),
              RadioListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text("Completed"),
                value: 27,
                groupValue: bloc.state.taskDetailsRadioValueSelect,
                onChanged: (int? value) {
                  setState(() {
                    bloc.add(TaskDetailsStatusRadioValueSet(statusId: value!));
                  });
                },
              ),
              Slider(
                value: bloc.state.currentSliderValue ?? 0.0,
                max: 100,
                divisions: 5,
                label: bloc.state.currentSliderValue?.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    bloc.add(TaskDetailsSliderValueSet(sliderValue: value));
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              bloc.add(TaskDetailsStatusUpdateRequest(
                  id: data!.id.toString(),
                  priority: data.priorityId.toString(),
                  context: context,
                  bloc: bloc));

              Navigator.pop(context);
            },
            child: const Text(
              'Okay',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  ListTile buildTitleAndValue({String? title, String? data}) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Text(
        '$title :',
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14.0),
      ),
      title: Text(data ?? ""),
    );
  }
}
