import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/res/common/debouncer.dart';
import 'package:onesthrm/res/enum.dart';

part 'qr_attendance_event.dart';
part 'qr_attendance_state.dart';

class QRAttendanceBloc extends Bloc<QRAttendanceEvent, QRAttendanceState>{
  final MetaClubApiClient metaClubApiClient;
  final Debounce debounce = Debounce(milliseconds: 400);

  QRAttendanceBloc({required this.metaClubApiClient})
  : super(const QRAttendanceState(status: NetworkStatus.initial)){
    on<QRScanData>(_onGetQrScanData);
  }

  FutureOr<void> _onGetQrScanData(QRScanData event, Emitter<QRAttendanceState> emit) async{

    debounce.run(() async{
      final data = {'qr_scan':event.qrData};
      try {
        final validateQRCode = await metaClubApiClient.checkQRValidations(data);
        // emit(state.copyWith(status: NetworkStatus.success));
      } on Exception catch (e) {
        emit(const QRAttendanceState(status: NetworkStatus.failure));
        throw NetworkRequestFailure(e.toString());
      }
    });
  }
}