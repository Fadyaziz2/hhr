class StatusModel {
  int? id;
  String? title;

  StatusModel({this.id, this.title});
}

List<StatusModel> statusList = [
  StatusModel(id: 24, title: 'Not Started'),
  StatusModel(id: 25, title: 'On Hold'),
  StatusModel(id: 26, title: 'In Progress'),
  StatusModel(id: 28, title: 'Cancelled'),
];