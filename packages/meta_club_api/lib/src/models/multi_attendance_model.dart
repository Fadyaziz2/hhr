import 'package:equatable/equatable.dart';

class MultiAttendanceModel extends Equatable {
  final bool? result;
  final String? message;
  final MultiAttendanceData? multiAttendanceData;

  const MultiAttendanceModel({
    this.result,
    this.message,
    this.multiAttendanceData,
  });

  factory MultiAttendanceModel.fromJson(Map<String, dynamic> json) =>
      MultiAttendanceModel(
        result: json["result"],
        message: json["message"],
        multiAttendanceData: json["data"] == null
            ? null
            : MultiAttendanceData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [result, message, multiAttendanceData];
}

class MultiAttendanceData extends Equatable {
  final String? date;
  final List<DateWiseReport>? dateWiseReport;

  const MultiAttendanceData({
    this.date,
    this.dateWiseReport,
  });

  factory MultiAttendanceData.fromJson(Map<String, dynamic> json) =>
      MultiAttendanceData(
        date: json["date"],
        dateWiseReport: json["date_wise_report"] == null
            ? []
            : List<DateWiseReport>.from(json["date_wise_report"]!
                .map((x) => DateWiseReport.fromJson(x))),
      );

  @override
  List<Object?> get props => [date, dateWiseReport];
}

class DateWiseReport extends Equatable {
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

  const DateWiseReport({
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

  factory DateWiseReport.fromJson(Map<String, dynamic> json) => DateWiseReport(
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

  @override
  List<Object?> get props => [
        fullDate,
        weekDay,
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
        checkOutReason,
      ];
}
