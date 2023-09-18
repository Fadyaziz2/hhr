import 'package:equatable/equatable.dart';

import '../../meta_club_api.dart';

class TaskDashboardModel extends Equatable {
  const TaskDashboardModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final TaskListCollection? data;

  factory TaskDashboardModel.fromJson(Map<String, dynamic> json) =>
      TaskDashboardModel(
        result: json["result"],
        message: json["message"],
        data: TaskListCollection.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, data];
}

class TaskDashboardData extends Equatable {
  const TaskDashboardData({
    this.statistics,
    this.completeTasksCollection,
  });

  final List<Statistics>? statistics;
  final List<TaskCompletionCollection>? completeTasksCollection;

  factory TaskDashboardData.fromJson(Map<String, dynamic> json) => TaskDashboardData(
        statistics: List<Statistics>.from(json["staticstics"].map((x) => Statistics.fromJson(x))),
        completeTasksCollection: List<TaskCompletionCollection>.from(json["complete_tasks_collection"].map((x) => TaskCompletionCollection.fromJson(x))),
      );

  @override
  List<Object?> get props => [statistics];
}

class TaskCompletionCollection extends Equatable {
  const TaskCompletionCollection({
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.usersCount,
    this.members,
    this.color,
  });

  final int? id;
  final String? title;
  final String? dateRange;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? usersCount;
  final List<TaskCompletionMembers>? members;
  final String? color;

  factory TaskCompletionCollection.fromJson(Map<String, dynamic> json) => TaskCompletionCollection(
    id: json["id"],
    title: json["title"],
    dateRange: json["date_range"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    usersCount: json["users_count"],
    members: List<TaskCompletionMembers>.from(json["members"].map((x) => TaskCompletionMembers.fromJson(x))),
    color: json["color"],
  );

  @override
  List<Object?> get props => [id,title,dateRange, startDate, endDate, usersCount, members, color];

}

class TaskCompletionMembers extends Equatable{
  const TaskCompletionMembers({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.department,
    this.designation,
  });

  final int ?id;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? department;
  final String? designation;

  factory TaskCompletionMembers.fromJson(Map<String, dynamic> json) => TaskCompletionMembers(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    department: json["department"],
    designation: json["designation"],
  );

  @override
  List<Object?> get props => [id, name, phone, email, avatar, department, designation];
}

class Statistics extends Equatable {
  const Statistics({
    this.count,
    this.text,
    this.status,
    this.image,
  });

  final int? count;
  final String? text;
  final String? status;
  final String? image;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        count: json["count"],
        text: json["text"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "text": text,
        "status": status,
        "image": image,
      };

  @override
  List<Object?> get props => [count, text, status, image];
}
