import 'package:dio/dio.dart';

class AttendanceBody {
  String? latitude;
  String? longitude;
  String? reason;
  int? mode;
  int? attendanceId;
  MultipartFile? selfieImage;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'reason': reason,
        'remote_mode': mode,
        'attendance_id': attendanceId,
        'selfie_image': selfieImage,
      };
}
