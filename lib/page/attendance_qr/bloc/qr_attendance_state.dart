part of 'qr_attendance_bloc.dart';

class QRAttendanceState extends Equatable {
  final NetworkStatus? status;
  final String? qrCode;

  const QRAttendanceState({this.status, this.qrCode});

  QRAttendanceState copyWith({NetworkStatus? status, String? qrCode}) {
    return QRAttendanceState(
        status: status ?? this.status, qrCode: qrCode ?? this.qrCode);
  }

  @override
  List<Object?> get props => [status, qrCode];
}
