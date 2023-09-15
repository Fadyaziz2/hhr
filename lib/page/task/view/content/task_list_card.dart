import 'package:flutter/material.dart';
import 'package:meta_club_api/meta_club_api.dart';

import 'content.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard(
      {Key? key,
      this.tapButtonColor,
      this.taskEndDate,
      this.taskName,
      this.userCount,
      required this.onTap,
      this.taskStartDate,
      this.taskListData, this.taskCompletionCollection})
      : super(key: key);

  final String? taskName, taskStartDate, taskEndDate;
  final int? userCount;
  final Color? tapButtonColor;
  final Function()? onTap;
  final TaskCollection? taskListData;
  final TaskCompletionCollection? taskCompletionCollection;

  @override
  Widget build(BuildContext context) {
    List<Widget> assigns = [];

    if (taskListData?.members != null) {

    }else{
      final data = taskCompletionCollection?.members;
      for (int i = 0; i < data!.length; i++) {
        assigns.add(Positioned(
          left: i * 15,
          top: 0.0,
          bottom: 0.0,
          child: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: data.elementAt(i).name != null
                      ? Text("Name : ${data.elementAt(i).name} ")
                      : const SizedBox(),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.elementAt(i).designation != null
                              ? Text(
                              "Designation : ${data.elementAt(i).designation ?? ""}")
                              : const SizedBox(),
                          data.elementAt(i).department != null
                              ? Text(
                              "Department : ${data.elementAt(i).department ?? ""}")
                              : const SizedBox(),
                          data.elementAt(i).phone != null
                              ? Text("Phone : ${data.elementAt(i).phone ?? ""}")
                              : const SizedBox(),
                          data.elementAt(i).email != null
                              ? Text("Email : ${data.elementAt(i).email ?? ""}")
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: 30.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage('${data.elementAt(i).avatar}'))),
              child: const SizedBox.shrink(),
            ),
          ),
        ));
      }
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        margin:  const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      taskName ?? "",
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Assignee",
                style: TextStyle(
                    color: Color(0xff8A8A8A),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25.0 * assigns.length,
                    height: 40.0,
                    child: Stack(children: assigns),
                  ),
                  userCount == 0
                      ? const SizedBox()
                      : Text(
                          '${userCount ?? 0}+',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Color(0xff8A8A8A),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                  const Spacer(),
                  TaskListButtonWithDate(
                    buttonColor: tapButtonColor,
                    firstDate: taskStartDate ?? "",
                    endData: taskEndDate ?? "",
                    verticalPadding: 6,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
