import 'package:equatable/equatable.dart';

class CheckInOut extends Equatable{
  final int? id;
  final int? remoteMode;
  final String? date;
  final String? checkIn;
  final String? checkInIp;
  final String? latitude;
  final String? longitude;
  final String? inStatus;

  const CheckInOut({this.id, this.remoteMode, this.date, this.checkIn, this.checkInIp, this.latitude, this.longitude, this.inStatus});

  factory CheckInOut.fromJson(Map<String,dynamic> json){
    return CheckInOut(
      id: json['id'],
      remoteMode: json['remote_mode_in'],
      date: json['date'],
      checkIn: json['check_in'],
      checkInIp: json['checkin_ip'],
      latitude: json['check_in_location'],
      longitude: json['check_in_latitude'],
      inStatus: json['in_status']
    );
  }

  Map<String,dynamic> toJson() => {
    'id':id,
    'remote_mode_in':remoteMode,
    'date':date,
    'check_in':checkIn,
    'checkin_ip':checkInIp,
    'check_in_location':latitude,
    'check_in_latitude':longitude,
    'in_status':inStatus,
  };

  @override
  List<Object?> get props => [id,remoteMode,date];
}