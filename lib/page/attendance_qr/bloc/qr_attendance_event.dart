part of 'qr_attendance_bloc.dart';

abstract class QRAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QRScanData extends QRAttendanceEvent {
  final String? qrData;

  QRScanData({this.qrData});

  @override
  List<Object?> get props => [qrData];
}
