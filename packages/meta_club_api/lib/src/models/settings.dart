import 'package:equatable/equatable.dart';

class Settings extends Equatable{

  Settings({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final Setting? data;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      Settings(
        result: json["result"],
        message: json["message"],
        data: Setting.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  List<Object?> get props => [result,message,data];
}

class Setting extends Equatable{
  Setting(
      {this.isIpEnabled,
      this.timeWish,
      this.timeZone,
      this.currencyCode,
      this.dutySchedule,
      this.breakStatus,
      this.isHr,
      this.isAdmin,
      this.isFaceRegistered,
      this.multiCheckIn,
      this.locationService,
      this.liveTracking,
      this.barikoiAPI,
      this.attendanceMethod});

  final bool? isIpEnabled;
  final bool? isHr;
  final bool? isAdmin;
  final bool? isFaceRegistered;
  final bool? multiCheckIn;
  final bool? locationService;
  final TimeWish? timeWish;
  final BarikoiAPI? barikoiAPI;
  final String? timeZone;
  final String? currencyCode;
  final String? attendanceMethod;
  final DutySchedule? dutySchedule;
  final BreakStatus? breakStatus;
  final LiveTracking? liveTracking;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
      isHr: json["is_hr"],
      isAdmin: json["is_admin"],
      isFaceRegistered: json["is_face_registered"],
      locationService: json["location_service"],
      isIpEnabled: json["is_ip_enabled"],
      timeWish: TimeWish.fromJson(json["time_wish"]),
      barikoiAPI: json["barikoi_api"].toString() != '[]'
          ? BarikoiAPI.fromJson(json["barikoi_api"])
          : null,
      timeZone: json["time_zone"],
      multiCheckIn: json["multi_checkin"],
      currencyCode: json["currency_code"],
      attendanceMethod: json["attendance_method"],
      dutySchedule: DutySchedule.fromJson(json['duty_schedule']),
      breakStatus: BreakStatus.fromJson(json["break_status"]),
      liveTracking: LiveTracking.fromJson(json["live_tracking"]));

  Map<String, dynamic> toJson() => {
        "is_ip_enabled": isIpEnabled,
        "time_wish": timeWish!.toJson(),
        "time_zone": timeZone,
        "currency_code": currencyCode,
        "duty_schedule": dutySchedule!.toJson(),
        "break_status": breakStatus!.toJson(),
        "live_tracking": liveTracking!.toJson(),
        "barikoi_api": barikoiAPI!.toJson(),
        "attendance_method": attendanceMethod,
      };

  @override
  List<Object?> get props => [isIpEnabled,currencyCode,attendanceMethod,isAdmin,isFaceRegistered];
}

class DutySchedule {
  DutySchedule({
    this.startTime,
    this.endTime,
  });

  Time? startTime;
  Time? endTime;

  factory DutySchedule.fromJson(Map<String, dynamic> json) => DutySchedule(
        startTime: Time.fromJson(json["start_time"]),
        endTime: Time.fromJson(json["end_time"]),
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime!.toJson(),
        "end_time": endTime!.toJson(),
      };
}

class Time {
  Time({
    this.hour,
    this.min,
    this.sec,
  });

  int? hour;
  int? min;
  int? sec;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        hour: json["hour"],
        min: json["min"],
        sec: json["sec"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "min": min,
        "sec": sec,
      };
}

class LiveTracking {
  LiveTracking({
    this.appSyncTime,
    this.liveDataStoreTime,
  });

  String? appSyncTime;
  String? liveDataStoreTime;

  factory LiveTracking.fromJson(Map<String, dynamic> json) => LiveTracking(
      appSyncTime: json["app_sync_time"],
      liveDataStoreTime: json["live_data_store_time"]);

  Map<String, dynamic> toJson() =>
      {"app_sync_time": appSyncTime, "live_data_store_time": liveDataStoreTime};
}

class BreakStatus {
  BreakStatus(
      {this.date, this.breakTime, this.backTime, this.status, this.diffTime});

  DateTime? date;
  String? breakTime;
  String? backTime;
  String? status;
  String? diffTime;

  factory BreakStatus.fromJson(Map<String, dynamic> json) => BreakStatus(
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      breakTime: json["break_time"],
      backTime: json["back_time"],
      status: json["status"],
      diffTime: json["diff_time"]);

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "break_time": breakTime,
        "back_time": backTime,
        "status": status,
        "diff_time": diffTime
      };
}

class TimeWish {
  TimeWish({
    this.wish,
    this.subTitle,
    this.image,
  });

  String? wish;
  String? subTitle;
  String? image;

  factory TimeWish.fromJson(Map<String, dynamic> json) => TimeWish(
        wish: json["wish"],
        subTitle: json["sub_title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "wish": wish,
        "sub_title": subTitle,
        "image": image,
      };
}

class BarikoiAPI {
  BarikoiAPI({this.key, this.secret, this.endPoint, this.statusId});

  String? key;
  String? secret;
  String? endPoint;
  int? statusId;

  factory BarikoiAPI.fromJson(Map<String, dynamic> json) => BarikoiAPI(
        key: json["key"],
        secret: json["secret"],
        endPoint: json["endpoint"],
        statusId: int.parse(
            json["status_id"] != null ? json["status_id"].toString() : '0'),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "secret": secret,
        "endpoint": endPoint,
        "status_id": statusId,
      };
}
