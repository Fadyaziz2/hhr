import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/bloc/bloc.dart';
import 'package:onesthrm/res/common/debouncer.dart';
import 'package:onesthrm/res/enum.dart';

import '../view/qr_attendance_screen.dart';

part 'qr_attendance_event.dart';

part 'qr_attendance_state.dart';

class QRAttendanceBloc extends Bloc<QRAttendanceEvent, QRAttendanceState> {
  final MetaClubApiClient metaClubApiClient;
  final Debounce debounce = Debounce(milliseconds: 400);

  QRAttendanceBloc({required this.metaClubApiClient}) : super(const QRAttendanceState(status: NetworkStatus.initial)) {
    on<QRScanData>(_onGetQrScanData);
  }

  FutureOr<void> _onGetQrScanData(
      QRScanData event, Emitter<QRAttendanceState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));
    final data = {'qr_scan': event.qrData};
    await metaClubApiClient.checkQRValidations(data).then((isSuccess) {
      if (isSuccess) {
        emit(state.copyWith(status: NetworkStatus.success));
        Navigator.pushReplacement(event.context!,
            AttendancePage.route(homeBloc: event.context!.read<HomeBloc>()));
      } else {
        emit(
          state.copyWith(
              status: NetworkStatus.failure,
              isSuccess: false,
              onErrorMessage: "The QR code doesn't match, retry"),
        );
        ScaffoldMessenger.of(event.context!).showSnackBar(
          SnackBar(content: Text(state.onErrorMessage ?? '')),
        );
        Navigator.pushReplacement(event.context!,
            MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
              value: event.context!.read<HomeBloc>(),
              child: const QRAttendanceScreen());
        }));
      }
    });
  }
}
