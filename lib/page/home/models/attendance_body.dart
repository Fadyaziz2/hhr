
class AttendanceBody {
  String? latitude;
  String? longitude;
  String? reason;
  int? mode;
  int? attendanceId;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'reason': reason,
        'remote_mode': mode,
        'attendance_id': attendanceId,
      };
}
