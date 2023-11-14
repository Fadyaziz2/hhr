import 'package:equatable/equatable.dart';

class VisitListModel extends Equatable{
  bool? result;
  String? message;
  VisitList? visitList;

  VisitListModel({
    this.result,
    this.message,
    this.visitList,
  });

  factory VisitListModel.fromJson(Map<String, dynamic> json) => VisitListModel(
    result: json["result"],
    message: json["message"],
    visitList: json["data"] == null ? null : VisitList.fromJson(json["data"]),
  );

  @override
  List<Object?> get props => [result, message, visitList];
}

class VisitList extends Equatable{
  List<MyVisit>? myVisits;

  VisitList({
    this.myVisits,
  });

  factory VisitList.fromJson(Map<String, dynamic> json) => VisitList(
    myVisits: json["my_visits"] == null ? [] : List<MyVisit>.from(json["my_visits"]!.map((x) => MyVisit.fromJson(x))),
  );

  @override
  List<Object?> get props => [myVisits];
}

class MyVisit {
  int? id;
  String? title;
  String? date;
  String? status;
  String? statusColor;

  MyVisit({
    this.id,
    this.title,
    this.date,
    this.status,
    this.statusColor,
  });

  factory MyVisit.fromJson(Map<String, dynamic> json) => MyVisit(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    status: json["status"],
    statusColor: json["status_color"],
  );

  @override
  List<Object?> get props => [id,title,date,status,statusColor];
}
