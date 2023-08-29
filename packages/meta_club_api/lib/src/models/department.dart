import 'package:equatable/equatable.dart';

class DepartmentsModel extends Equatable {
  final bool? result;
  final String? message;
  final DepartmentsListData? data;

  const DepartmentsModel({
    this.result,
    this.message,
    this.data,
  });

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      DepartmentsModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DepartmentsListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [result, message, data];
}

class DepartmentsListData extends Equatable {
  final List<DepartmentsData>? departments;

  const DepartmentsListData({
    this.departments,
  });

  factory DepartmentsListData.fromJson(Map<String, dynamic> json) =>
      DepartmentsListData(
        departments: json["departments"] == null
            ? []
            : List<DepartmentsData>.from(
                json["departments"]!.map((x) => DepartmentsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "departments": departments == null
            ? []
            : List<dynamic>.from(departments!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [departments];
}

class DepartmentsData extends Equatable {
  final int? id;
  final String? title;

  const DepartmentsData({
    this.id,
    this.title,
  });

  factory DepartmentsData.fromJson(Map<String, dynamic> json) =>
      DepartmentsData(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };

  @override
  List<Object?> get props => [id, title];
}
