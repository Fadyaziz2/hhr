import 'package:equatable/equatable.dart';

class NotificationResponse extends Equatable {
  bool? result;
  String? message;
  NotificationData? data;

  NotificationResponse({
    this.result,
    this.message,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : NotificationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class NotificationData extends Equatable {
  List<NotificationModelData>? notifications;

  NotificationData({
    this.notifications,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        notifications: json["notifications"] == null
            ? []
            : List<NotificationModelData>.from(json["notifications"]!
                .map((x) => NotificationModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [notifications];
}

class NotificationModelData extends Equatable {
  int? id;
  String? sender;
  int? senderId;
  String? title;
  String? body;
  String? image;
  String? date;
  String? slag;
  dynamic readAt;
  bool? isRead;

  NotificationModelData({
    this.id,
    this.sender,
    this.senderId,
    this.title,
    this.body,
    this.image,
    this.date,
    this.slag,
    this.readAt,
    this.isRead,
  });

  factory NotificationModelData.fromJson(Map<String, dynamic> json) =>
      NotificationModelData(
        id: json["id"],
        sender: json["sender"],
        senderId: json["sender_id"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        date: json["date"],
        slag: json["slag"],
        readAt: json["read_at"],
        isRead: json["is_read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "sender_id": senderId,
        "title": title,
        "body": body,
        "image": image,
        "date": date,
        "slag": slag,
        "read_at": readAt,
        "is_read": isRead,
      };
  @override
  List<Object?> get props => [
        id,
        sender,
        senderId,
        title,
        body,
        image,
        date,
        slag,
        readAt,
        isRead,
      ];
}
