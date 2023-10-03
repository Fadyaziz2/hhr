import 'package:equatable/equatable.dart';

class AttendanceReport extends Equatable {
  const AttendanceReport({
    this.result,
    this.message,
    this.reportData,
  });

  final bool? result;
  final String? message;
  final AttendanceReportData? reportData;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) =>
      AttendanceReport(
        result: json["result"],
        message: json["message"],
        reportData: AttendanceReportData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": reportData!.toJson(),
      };

  @override
  List<Object?> get props => [result, message, reportData];
}

class AttendanceReportData extends Equatable {
  const AttendanceReportData({
    this.attendanceSummary,
    this.dailyReport,
  });

  final AttendanceSummary? attendanceSummary;
  final List<DailyReport>? dailyReport;

  factory AttendanceReportData.fromJson(Map<String, dynamic> json) =>
      AttendanceReportData(
        attendanceSummary:
            AttendanceSummary.fromJson(json["attendance_summary"]),
        dailyReport: List<DailyReport>.from(
            json["daily_report"].map((x) => DailyReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attendance_summary": attendanceSummary!.toJson(),
        "daily_report": List<dynamic>.from(dailyReport!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [attendanceSummary, dailyReport];
}

class AttendanceSummary extends Equatable {
  const AttendanceSummary({
    this.workingDays,
    this.present,
    this.workTime,
    this.absent,
    this.totalOnTimeIn,
    this.totalLeave,
    this.totalEarlyIn,
    this.totalLateIn,
    this.totalLeftTimely,
    this.totalLeftEarly,
    this.totalLeftLater,
  });

  final String? workingDays;
  final String? present;
  final String? workTime;
  final String? absent;
  final String? totalOnTimeIn;
  final String? totalLeave;
  final String? totalEarlyIn;
  final String? totalLateIn;
  final String? totalLeftTimely;
  final String? totalLeftEarly;
  final String? totalLeftLater;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      AttendanceSummary(
        workingDays: json["working_days"],
        present: json["present"],
        workTime: json["work_time"],
        absent: json["absent"],
        totalOnTimeIn: json["total_on_time_in"],
        totalLeave: json["total_leave"],
        totalEarlyIn: json["total_early_in"],
        totalLateIn: json["total_late_in"],
        totalLeftTimely: json["total_left_timely"],
        totalLeftEarly: json["total_left_early"],
        totalLeftLater: json["total_left_later"],
      );

  Map<String, dynamic> toJson() => {
        "working_days": workingDays,
        "present": present,
        "work_time": workTime,
        "absent": absent,
        "total_on_time_in": totalOnTimeIn,
        "total_leave": totalLeave,
        "total_early_in": totalEarlyIn,
        "total_late_in": totalLateIn,
        "total_left_timely": totalLeftTimely,
        "total_left_early": totalLeftEarly,
        "total_left_later": totalLeftLater,
      };

  @override
  List<Object?> get props => [
        workingDays,
        present,
        workTime,
        absent,
        totalOnTimeIn,
        totalLeave,
        totalEarlyIn,
        totalLateIn,
        totalLeftTimely,
        totalLeftEarly,
        totalLeftLater
      ];
}

class DailyReport extends Equatable {
  const DailyReport({
    this.fullDate,
    this.weekDay,
    this.date,
    this.status,
    this.remoteModeIn,
    this.remoteModeOut,
    this.checkIn,
    this.checkInStatus,
    this.checkOutStatus,
    this.checkInLocation,
    this.checkInReason,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutReason,
  });

  final String? fullDate;
  final String? weekDay;
  final String? date;
  final String? status;
  final String? remoteModeIn;
  final String? remoteModeOut;
  final String? checkIn;
  final String? checkInStatus;
  final String? checkOutStatus;
  final String? checkInLocation;
  final String? checkInReason;
  final String? checkOut;
  final String? checkOutLocation;
  final String? checkOutReason;

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        fullDate: json["full_date"],
        weekDay: json["week_day"],
        date: json["date"],
        status: json["status"],
        remoteModeIn: json["remote_mode_in"],
        remoteModeOut: json["remote_mode_out"],
        checkIn: json["check_in"],
        checkInStatus: json["check_in_status"],
        checkOutStatus: json["check_out_status"],
        checkInLocation: json["check_in_location"],
        checkInReason: json["check_in_reason"],
        checkOut: json["check_out"],
        checkOutLocation: json["check_out_location"],
        checkOutReason: json["check_out_reason"],
      );

  Map<String, dynamic> toJson() => {
        "full_date": fullDate,
        "week_day": weekDay,
        "date": date,
        "status": status,
        "remote_mode_in": remoteModeIn,
        "remote_mode_out": remoteModeOut,
        "check_in": checkIn,
        "check_in_status": checkInStatus,
        "check_out_status": checkOutStatus,
        "check_in_location": checkInLocation,
        "check_in_reason": checkInReason,
        "check_out": checkOut,
        "check_out_location": checkOutLocation,
        "check_out_reason": checkOutReason,
      };

  @override
  List<Object?> get props => [
        fullDate,
        weekDay,
        date,
        status,
        remoteModeIn,
        remoteModeOut,
        checkIn,
        checkInStatus,
        checkOutStatus,
        checkInLocation,
        checkInReason,
        checkOut,
        checkOutLocation,
        checkOutReason
      ];
}
