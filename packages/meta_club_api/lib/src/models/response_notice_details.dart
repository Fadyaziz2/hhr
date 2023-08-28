import 'package:equatable/equatable.dart';

class ResponseNoticeDetails extends Equatable {
  ResponseNoticeDetails({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  NoticeDetailsData? data;

  factory ResponseNoticeDetails.fromJson(Map<String, dynamic> json) =>
      ResponseNoticeDetails(
        result: json["result"],
        message: json["message"],
        data: NoticeDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class NoticeDetailsData extends Equatable {
  NoticeDetailsData({
    this.id,
    this.subject,
    this.description,
    this.date,
    this.file,
  });

  int? id;
  String? subject;
  String? description;
  String? date;
  String? file;

  factory NoticeDetailsData.fromJson(Map<String, dynamic> json) =>
      NoticeDetailsData(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        date: json["date"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "date": date,
        "file": file,
      };
  @override
  List<Object?> get props => [id, subject, description, date, file];
}
