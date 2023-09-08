import 'package:equatable/equatable.dart';

class TaskDashboardModel extends Equatable {
  const TaskDashboardModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final TaskDashboardData? data;

  factory TaskDashboardModel.fromJson(Map<String, dynamic> json) =>
      TaskDashboardModel(
        result: json["result"],
        message: json["message"],
        data: TaskDashboardData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, data];
}

class TaskDashboardData extends Equatable {
  const TaskDashboardData({
    this.statistics,
  });

  final List<Statistics>? statistics;

  factory TaskDashboardData.fromJson(Map<String, dynamic> json) =>
      TaskDashboardData(
        statistics: List<Statistics>.from(
            json["staticstics"].map((x) => Statistics.fromJson(x))),
      );

  @override
  List<Object?> get props => [statistics];
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
