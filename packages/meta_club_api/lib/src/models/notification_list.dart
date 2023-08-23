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

class NotificationData {
  List<Notification>? notifications;

  NotificationData({
    this.notifications,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification extends Equatable {
  String? id;
  String? sender;
  int? senderId;
  String? title;
  String? body;
  String? image;
  String? date;
  String? slag;
  DateTime? readAt;
  bool? isRead;

  Notification({
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

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        sender: json["sender"],
        senderId: json["sender_id"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        date: json["date"],
        slag: json["slag"],
        readAt:
            json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
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
        "read_at": readAt?.toIso8601String(),
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
