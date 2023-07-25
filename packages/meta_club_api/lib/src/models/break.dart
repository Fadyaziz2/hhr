import 'package:equatable/equatable.dart';

import '../../meta_club_api.dart';

class Break extends Equatable{
  const Break({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final BreakItem? data;

  factory Break.fromJson(Map<String, dynamic> json) => Break(
    result: json["result"],
    message: json["message"],
    data: BreakItem.fromJson(json["data"]),
  );

  @override
  List<Object?> get props => [result,message,data];
}

class BreakItem extends Equatable{
  const BreakItem({
    this.companyId,
    this.userId,
    this.date,
    this.breakTime,
    this.backTime,
    this.reason,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.status,
    this.breakBackHistory
  });

  final int? companyId;
  final int? userId;
  final DateTime? date;
  final String? breakTime;
  final String? backTime;
  final String? reason;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? status;
  final BreakBackHistory? breakBackHistory;

  factory BreakItem.fromJson(Map<String, dynamic> json) => BreakItem(
    companyId: int.parse(json["company_id"].toString()),
    userId: int.parse(json["user_id"].toString()),
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    breakTime: json["break_time"],
    backTime: json["back_time"],
    reason: json["reason"],
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    breakBackHistory: json["histroy"] != null ? BreakBackHistory.fromJson(json['histroy']) : null,
    id: json["id"],
    status: json["status"],
  );

  @override
  List<Object?> get props => [id,status,date,breakTime,backTime,id];
}