class TaskStatusModel {
  int? id;
  String? title;

  TaskStatusModel({this.id, this.title});
}

List<TaskStatusModel> statusList = [
  TaskStatusModel(id: 24, title: 'Not Started'),
  TaskStatusModel(id: 25, title: 'On Hold'),
  TaskStatusModel(id: 26, title: 'In Progress'),
  TaskStatusModel(id: 28, title: 'Cancelled'),
];