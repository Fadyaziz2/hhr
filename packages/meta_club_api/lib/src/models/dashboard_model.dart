import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable{
  DashboardModel({
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
        data: DashboardData.fromJson(json["data"]),
      );
  @override
  List<Object?> get props => [data];
}

class DashboardData extends Equatable{

  DashboardData({
    this.today,
    this.currentMonth,
    this.upcomingEvents,
    this.appointments,
    this.menus,
    this.config,
    this.attendanceData
  });

  final List<TodayData>? today;
  final List<CurrentMonthData>? currentMonth;
  final List<UpcomingEvent>? upcomingEvents;
  final List<Appointment>? appointments;
  final List<Menu>? menus;
  final AttendanceData? attendanceData;
  final Config? config;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        today: List<TodayData>.from(json["today"].map((x) => TodayData.fromJson(x))),
        upcomingEvents: List<UpcomingEvent>.from(json["upcoming_events"].map((x) => UpcomingEvent.fromJson(x))),
        appointments: List<Appointment>.from(json["appoinment_list"].map((x) => Appointment.fromJson(x))),
        currentMonth: List<CurrentMonthData>.from(json["current_month"].map((x) => CurrentMonthData.fromJson(x))),
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        attendanceData: AttendanceData.fromJson(json['attendance_status']),
        config: Config.fromJson(json['config']),
      );
  @override
  List<Object?> get props => [today,currentMonth,upcomingEvents,appointments,attendanceData,config,menus];
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

class AttendanceData{
  final int? id;
  final bool? checkIn;
  final bool? checkout;
  final String? inTime;
  final String? outTime;
  final String? stayTime;

  AttendanceData({this.id, this.checkIn, this.checkout, this.inTime, this.outTime, this.stayTime});

  factory AttendanceData.fromJson(Map<String,dynamic> json){
    return AttendanceData(
       id: json['id'],
       checkIn: json['checkin'],
       checkout: json['checkout'],
       inTime: json['in_time'],
       outTime: json['out_time'],
       stayTime: json['stay_time'],
    );
  }
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
        this.participants,
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
  List<Participant>? participants;
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
    participants: List<Participant>.from(json["participants"].map((x) => Participant.fromJson(x))),
    appointmentWith: json["appoinmentWith"],
  );
}

class CurrentMonthData {

  CurrentMonthData({this.image, this.title, this.number, this.slug});

  String? image;
  String? title;
  dynamic number;
  String? slug;

  factory CurrentMonthData.fromJson(Map<String, dynamic> json) => CurrentMonthData(
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
  UpcomingEvent({
    this.id,
    this.title,
    this.date,
    this.day,
    this.time,
    this.startDate,
    this.image
  });

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
    image: json["attachment_file_id"]
  );
}

class Participant{
  final String? name;
  final String? isAgree;
  final String? isPresent;
  final String? start;
  final String? end;
  final String? duration;

  Participant({this.name, this.isAgree, this.isPresent, this.start, this.end,
      this.duration});

  factory Participant.fromJson(Map<String,dynamic> json){
    return Participant(
      name: json['name'],
      isAgree: json['is_agree'],
      isPresent: json['is_agree'],
      start: json['is_agree'],
      end: json['is_agree'],
    );
  }

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

  BreakData({
     this.breakTime,
     this.backTime,
     this.reason,
     this.createdAt,
     this.updatedAt,
     this.status,
     this.diffTime,
  });

  factory BreakData.fromJson(Map<String, dynamic> json) => BreakData(
    breakTime: json["break_time"],
    backTime: json["back_time"],
    reason: json["reason"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    status: json["status"],
    diffTime: json["diff_time"],
  );
}

class DutyScheduleData {
  final TimeData? startTime;
  final TimeData? endTime;

  DutyScheduleData({
     this.startTime,
     this.endTime,
  });

  factory DutyScheduleData.fromJson(Map<String, dynamic> json) => DutyScheduleData(
    startTime: TimeData.fromJson(json["start_time"]),
    endTime: TimeData.fromJson(json["end_time"]),
  );
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

  factory LiveTrackingData.fromJson(Map<String, dynamic> json) => LiveTrackingData(
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

  factory LocationServices.fromJson(Map<String, dynamic> json) => LocationServices(
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
}
