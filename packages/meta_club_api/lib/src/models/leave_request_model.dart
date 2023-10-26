import 'package:equatable/equatable.dart';

class LeaveRequestModel extends Equatable{
  bool? result;
  String? message;
  LeaveRequestData? leaveRequestData;

  LeaveRequestModel({
    this.result,
    this.message,
    this.leaveRequestData,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) => LeaveRequestModel(
    result: json["result"],
    message: json["message"],
    leaveRequestData: json["data"] == null ? null : LeaveRequestData.fromJson(json["data"]),
  );

  @override
  // TODO: implement props
  List<Object?> get props => [result,message,leaveRequestData];

}

class LeaveRequestData extends Equatable{
  List<LeaveRequestValue>? leaveRequests;

  LeaveRequestData({
    this.leaveRequests,
  });

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) => LeaveRequestData(
    leaveRequests: json["leaveRequests"] == null ? [] : List<LeaveRequestValue>.from(json["leaveRequests"]!.map((x) => LeaveRequestValue.fromJson(x))),
  );

  @override
  List<Object?> get props => [leaveRequests];
}

class LeaveRequestValue extends Equatable{
  int? id;
  String? type;
  int? days;
  String? applyDate;
  String? status;
  String? colorCode;

  LeaveRequestValue({
    this.id,
    this.type,
    this.days,
    this.applyDate,
    this.status,
    this.colorCode,
  });

  factory LeaveRequestValue.fromJson(Map<String, dynamic> json) => LeaveRequestValue(
    id: json["id"],
    type: json["type"],
    days: json["days"],
    applyDate: json["apply_date"],
    status: json["status"],
    colorCode: json["color_code"],
  );
  @override
  List<Object?> get props => [id,type,days,applyDate,status,colorCode];

}
