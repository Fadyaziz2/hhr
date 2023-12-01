import 'package:equatable/equatable.dart';
import 'break_history.dart';

class DashboardModel extends Equatable {
  const DashboardModel({
    this.result,
    this.message,
    this.data,
  });

  final bool? result;
  final String? message;
  final DashboardData? data;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] != null ? DashboardData.fromJson(json["data"]) : null,
      );

  @override
  List<Object?> get props => [data];
}

class DashboardData extends Equatable {
  const DashboardData(
      {this.today,
      this.currentMonth,
      this.upcomingEvents,
      this.appointments,
      this.menus,
      this.config,
      this.breakHistory,
      this.attendanceData});

  final List<TodayData>? today;
  final List<CurrentMonthData>? currentMonth;
  final List<UpcomingEvent>? upcomingEvents;
  final List<Appointment>? appointments;
  final List<Menu>? menus;
  final AttendanceData? attendanceData;
  final Config? config;
  final BreakHistory? breakHistory;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        today: List<TodayData>.from(
            json["today"].map((x) => TodayData.fromJson(x))),
        upcomingEvents: List<UpcomingEvent>.from(
            json["upcoming_events"].map((x) => UpcomingEvent.fromJson(x))),
        appointments: List<Appointment>.from(
            json["appoinment_list"].map((x) => Appointment.fromJson(x))),
        currentMonth:json["current_month"] != null ?  List<CurrentMonthData>.from(
            json["current_month"].map((x) => CurrentMonthData.fromJson(x))) : [],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        attendanceData: AttendanceData.fromJson(json['attendance_status']),
        breakHistory: json['break_history_data'] != null
            ? BreakHistory.fromJson(json['break_history_data'])
            : null,
        config: Config.fromJson(json['config']),
      );

  Map<String, dynamic> toJson() => {
        "today": today?.map((e) => e.toJson()).toList(),
        "upcoming_events": upcomingEvents?.map((e) => e.toJson()).toList(),
        "appoinment_list": appointments?.map((e) => e.toJson()).toList(),
        "menus": menus?.map((e) => e.toJson()).toList(),
        "attendance_status": attendanceData?.toJson(),
        "break_history_data": breakHistory?.toJson(),
        "config": config?.toJson(),
      };

  @override
  List<Object?> get props => [
        today,
        currentMonth,
        upcomingEvents,
        appointments,
        attendanceData,
        config,
        menus
      ];
}

class Menu {
  Menu({
    this.name,
    this.slug,
    this.position,
    this.icon,
    this.imageType,
  });

  String? name;
  String? slug;
  int? position;
  String? icon;
  String? imageType;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        slug: json["slug"],
        position: json["position"],
        icon: json["icon"],
        imageType: json["image_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "position": position,
        "icon": icon,
        "image_type": imageType,
      };
}

class AttendanceData {
  final int? id;
  final bool? checkIn;
  final bool? checkout;
  final String? inTime;
  final String? outTime;
  final String? stayTime;

  AttendanceData(
      {this.id,
      this.checkIn,
      this.checkout,
      this.inTime,
      this.outTime,
      this.stayTime});

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      checkIn: json['checkin'],
      checkout: json['checkout'],
      inTime: json['in_time'],
      outTime: json['out_time'],
      stayTime: json['stay_time'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id'": id,
    "checkin": checkIn,
    "checkout": checkout,
    "in_time": inTime,
    "out_time": outTime,
    "stay_time": stayTime,
  };
}

class Appointment {
  Appointment(
      {this.id,
      this.title,
      this.date,
      this.day,
      this.time,
      this.startAt,
      this.endAt,
      this.location,
      this.duration,
      this.participants = const [],
      this.appointmentWith});

  int? id;
  String? title;
  String? date;
  String? day;
  String? time;
  String? startAt;
  String? endAt;
  String? location;
  String? duration;
  List<Participant> participants;
  String? appointmentWith;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        day: json["day"],
        time: json["time"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        location: json["location_track"],
        duration: json["duration"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
        appointmentWith: json["appoinmentWith"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "day": day,
        "time": time,
        "start_at": startAt,
        "end_at": endAt,
        "location_track": location,
        "duration": duration,
        "participants": participants.map((e) => e.toJson()).toList(),
        "appoinmentWith": appointmentWith
      };
}

class BreakHistory {
  final TimeBreak? timeBreak;
  final String? time;
  final bool? hasBreak;
  final BreakBackHistory? breakHistory;

  BreakHistory({this.timeBreak, this.hasBreak, this.breakHistory, this.time});

  factory BreakHistory.fromJson(Map<String, dynamic> json) {
    return BreakHistory(
        time: json['total_break_time'] != null ? json['total_break_time'] : null,
        timeBreak: TimeBreak.fromString(json['total_break_time']),
        hasBreak: json['has_break'],
        breakHistory: BreakBackHistory.fromJson(json['break_history']));
  }

  Map<String, dynamic> toJson() => {
        "total_break_time": timeBreak?.toJson(),
        "has_break": hasBreak,
        "break_history": breakHistory?.toJson()
      };

  @override
  String toString() {
    return '${timeBreak?.hour}:${timeBreak?.min}:${timeBreak?.sec}:';
  }
}

class TimeBreak {
  final int hour;
  final int min;
  final int sec;

  TimeBreak({this.hour = 0, this.min = 0, this.sec = 0});

  factory TimeBreak.fromString(String time) {
    final t = time.split(':');
    return TimeBreak(
        hour: int.parse(t[0]), min: int.parse(t[1]), sec: int.parse(t[2]));
  }

  Map<String, dynamic> toJson() => {"hour": hour, "min": min, "sec": sec};

  @override
  String toString() {
    return '$hour:$min:$sec';
  }
}

class CurrentMonthData {
  CurrentMonthData({this.image, this.title, this.number, this.slug});

  String? image;
  String? title;
  dynamic number;
  String? slug;

  factory CurrentMonthData.fromJson(Map<String, dynamic> json) =>
      CurrentMonthData(
          image: json["image"],
          title: json["title"],
          number: json["number"],
          slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "number": number,
      };
}

class TodayData {
  TodayData({this.image, this.title, this.number, this.slug});

  String? image;
  String? title;
  dynamic number;
  String? slug;

  factory TodayData.fromJson(Map<String, dynamic> json) => TodayData(
      image: json["image"],
      title: json["title"],
      number: json["number"],
      slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "number": number,
      };
}

class UpcomingEvent {
  UpcomingEvent(
      {this.id,
      this.title,
      this.date,
      this.day,
      this.time,
      this.startDate,
      this.image});

  int? id;
  String? title;
  String? date;
  String? day;
  String? time;
  String? startDate;
  String? image;

  factory UpcomingEvent.fromJson(Map<String, dynamic> json) => UpcomingEvent(
      id: json["id"],
      title: json["title"],
      date: json["date"],
      day: json["day"],
      time: json["time"],
      startDate: json["start_date"],
      image: json["attachment_file_id"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "day": day,
    "time": time,
    "start_date": startDate,
    "attachment_file_id": image
  };
}

class Participant {
  final String? name;
  final String? isAgree;
  final String? isPresent;
  final String? start;
  final String? end;
  final String? duration;

  Participant(
      {this.name,
      this.isAgree,
      this.isPresent,
      this.start,
      this.end,
      this.duration});

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
        name: json['name'],
        isAgree: json['is_agree'],
        isPresent: json['is_present'],
        start: json['appoinment_started_at'],
        end: json['appoinment_ended_at'],
        duration: json['appoinment_duration']);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "is_agree": isAgree,
        "is_present": isPresent,
        "appoinment_started_at": start,
        "appoinment_ended_at": end,
        "appoinment_duration": duration
      };
}

class Config {
  final bool? isAdmin;
  final bool? isHr;
  final bool? isManager;
  final bool? isFaceRegistered;
  final bool? multiCheckIn;
  final bool? locationBind;
  final bool? isIpEnabled;
  final TimeWishData? timeWish;
  final String? timeZone;
  final String? currencySymbol;
  final String? currencyCode;
  final String? attendanceMethod;
  final DutyScheduleData? dutySchedule;
  final LocationServices? locationServices;
  final String? googleApiKey;
  final BarikoiApi? barikoiApi;
  final BreakData? breakStatus;
  final LiveTrackingData? liveTracking;
  final bool? locationService;
  final bool? isTeamLead;

  Config({
    this.isAdmin,
    this.isHr,
    this.isManager,
    this.isFaceRegistered,
    this.multiCheckIn,
    this.locationBind,
    this.isIpEnabled,
    this.timeWish,
    this.timeZone,
    this.currencySymbol,
    this.currencyCode,
    this.attendanceMethod,
    this.dutySchedule,
    this.locationServices,
    this.googleApiKey,
    this.barikoiApi,
    this.breakStatus,
    this.liveTracking,
    this.locationService,
    this.isTeamLead,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        isAdmin: json["is_admin"],
        isHr: json["is_hr"],
        isManager: json["is_manager"],
        isFaceRegistered: json["is_face_registered"],
        multiCheckIn: json["multi_checkin"],
        locationBind: json["location_bind"],
        isIpEnabled: json["is_ip_enabled"],
        timeWish: TimeWishData.fromJson(json["time_wish"]),
        timeZone: json["time_zone"],
        currencySymbol: json["currency_symbol"],
        currencyCode: json["currency_code"],
        attendanceMethod: json["attendance_method"],
        dutySchedule: DutyScheduleData.fromJson(json["duty_schedule"]),
        locationServices: LocationServices.fromJson(json["location_services"]),
        googleApiKey: json["google_api_key"],
        barikoiApi: BarikoiApi.fromJson(json["barikoi_api"]),
        breakStatus: BreakData.fromJson(json["break_status"]),
        liveTracking: LiveTrackingData.fromJson(json["live_tracking"]),
        locationService: json["location_service"],
        isTeamLead: json["is_team_lead"],
      );

  Map<String, dynamic> toJson() => {
        'is_hr': isHr,
        'is_admin': isAdmin,
        'is_manager': isManager,
        'is_face_registered': isFaceRegistered,
        'location_service': locationService,
        'location_services': locationServices?.toJson(),
        'is_ip_enabled': isIpEnabled,
        'location_bind': locationBind,
        'time_wish': timeWish?.toJson(),
        'time_zone': timeZone,
        'multi_checkin': multiCheckIn,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'attendance_method': attendanceMethod,
        'duty_schedule': dutySchedule?.toJson(),
        'break_status': breakStatus?.toJson(),
        'live_tracking': liveTracking?.toJson(),
        'google_api_key': googleApiKey,
        'is_team_lead': isTeamLead
      };
}

class BarikoiApi {
  String? key;
  String? secret;
  String? endpoint;
  int? statusId;

  BarikoiApi({
    this.key,
    this.secret,
    this.endpoint,
    this.statusId,
  });

  factory BarikoiApi.fromJson(Map<String, dynamic> json) => BarikoiApi(
        key: json["key"],
        secret: json["secret"],
        endpoint: json["endpoint"],
        statusId: json["status_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "secret": secret,
        "endpoint": endpoint,
        "status_id": statusId,
      };
}

class BreakData {
  String? breakTime;
  String? backTime;
  String? reason;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? diffTime;
  TimeBreak? timeBreak;

  BreakData({
    this.breakTime,
    this.backTime,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.diffTime,
    this.timeBreak,
  });

  factory BreakData.fromJson(Map<String, dynamic> json) => BreakData(
        breakTime: json['break_time'] != "" ? json["break_time"] : null,
        backTime: json['back_time'] != "" ? json["back_time"] : null,
        reason: json["reason"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
        diffTime: json["diff_time"],
        timeBreak: json['diff_time'] != ""
            ? TimeBreak.fromString(json['diff_time'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "break_time": breakTime,
        "back_time": backTime,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "diff_time": timeBreak?.toJson(),
      };
}

class DutyScheduleData {
  final TimeData? startTime;
  final TimeData? endTime;

  DutyScheduleData({
    this.startTime,
    this.endTime,
  });

  factory DutyScheduleData.fromJson(Map<String, dynamic> json) =>
      DutyScheduleData(
        startTime: TimeData.fromJson(json["start_time"]),
        endTime: TimeData.fromJson(json["end_time"]),
      );

  Map<String, dynamic> toJson() =>
      {"start_time": startTime, "end_time": endTime};
}

class TimeData {
  final int? hour;
  final int? min;
  final int? sec;

  TimeData({
    this.hour,
    this.min,
    this.sec,
  });

  factory TimeData.fromJson(Map<String, dynamic> json) => TimeData(
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

class LiveTrackingData {
  String? appSyncTime;
  String? liveDataStoreTime;

  LiveTrackingData({
    this.appSyncTime,
    this.liveDataStoreTime,
  });

  factory LiveTrackingData.fromJson(Map<String, dynamic> json) =>
      LiveTrackingData(
        appSyncTime: json["app_sync_time"],
        liveDataStoreTime: json["live_data_store_time"],
      );

  Map<String, dynamic> toJson() => {
        "app_sync_time": appSyncTime,
        "live_data_store_time": liveDataStoreTime,
      };
}

class LocationServices {
  final bool? google;
  final bool? barikoi;

  LocationServices({
    this.google,
    this.barikoi,
  });

  factory LocationServices.fromJson(Map<String, dynamic> json) =>
      LocationServices(
        google: json["google"],
        barikoi: json["barikoi"],
      );

  Map<String, dynamic> toJson() => {
        "google": google,
        "barikoi": barikoi,
      };
}

class TimeWishData {
  final String? wish;
  final String? subTitle;
  final String? image;

  TimeWishData({
    this.wish,
    this.subTitle,
    this.image,
  });

  factory TimeWishData.fromJson(Map<String, dynamic> json) => TimeWishData(
        wish: json["wish"],
        subTitle: json["sub_title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() =>
      {"wish": wish, "sub_title": subTitle, "image": image};
}
