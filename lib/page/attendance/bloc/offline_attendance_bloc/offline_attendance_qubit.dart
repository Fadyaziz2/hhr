import 'dart:async';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'offline_attendance_state.dart';

class OfflineCubit extends Cubit<OfflineAttendanceState> {
  final AttendanceService _attendanceService;
  late StreamSubscription<OnOnlineAttendanceUpdateEvent> onlineSubscription;
  late StreamSubscription<OnOfflineAttendanceUpdateEvent> offlineSubscription;

  OfflineCubit({required AttendanceService attendanceService})
      : _attendanceService = attendanceService,
        super(const OfflineAttendanceState()) {
    onOnlineCheckInOutData();

    onlineSubscription = eventBus.on<OnOnlineAttendanceUpdateEvent>().listen((event) {
      onOnlineCheckInOutData(body: event.body);
    });

    offlineSubscription = eventBus.on<OnOfflineAttendanceUpdateEvent>().listen((event) {
      onOfflineCheckInOutData(body: event.body);
    });
  }

  onOnlineCheckInOutData({AttendanceBody? body}) {
    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    bool isCheckedIn = body?.inTime != null;
    bool isCheckedOut = body?.outTime != null;
    if (body != null) {
      if (isCheckedOut == true) {
        isCheckedIn = false;
        body = body.copyWith(attendanceId: null);
      }
      _attendanceService.checkInOut(checkData: body, isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, multipleAttendanceEnabled: true).then((_) {
        AttendanceBody? localAttendanceData = _attendanceService.getCheckDataByDate(date: date);
        localAttendanceData = _attendanceService.getCheckDataByDate(date: date);
        if (isCheckedOut && body?.isOffline == true) {
          ///-----------------------Try to sync attendance data with server when user try to checkout---------------
          eventBus.fire(const OfflineDataSycEvent());
        }

        ///--------------------------------------*********--------------------------------------------------------
        emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
      });
    } else {
      AttendanceBody? localAttendanceData = _attendanceService.getCheckDataByDate(date: date);
      isCheckedIn = localAttendanceData?.attendanceId != null;
      isCheckedOut = localAttendanceData?.attendanceId == null;

      if(localAttendanceData?.attendanceId == null){
        if(localAttendanceData?.inTime != null){
          isCheckedIn = true;
        }
        if(localAttendanceData?.outTime != null){
          isCheckedOut = true;
          isCheckedIn = false;
        }
        if(localAttendanceData?.inTime != null && localAttendanceData?.outTime != null){
          isCheckedIn = false;
          isCheckedOut = false;
        }
      }

      emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
    }
  }

  onOfflineCheckInOutData({AttendanceBody? body}) {
    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    bool isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: date);
    bool isCheckedOut = _attendanceService.isAlreadyInCheckedOut(date: date);
    AttendanceBody? localAttendanceData = _attendanceService.getCheckDataByDate(date: date);

    if (body != null) {
      ///for offline attendance we need date, outTime, inTime
      if (isCheckedIn && isCheckedOut == false) {
        body = body.copyWith(inTime: localAttendanceData?.inTime);
        body = body.copyWith(outTime: DateFormat('h:mm a', 'en').format(DateTime.now()));
      } else {
        body = body.copyWith(inTime: DateFormat('h:mm a', 'en').format(DateTime.now()));
        body = body.copyWith(outTime: null);
      }

      _attendanceService.offlineCheckInOut(checkData: body, isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, multipleAttendanceEnabled: true).then((_) {
        isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: date);
        isCheckedOut = _attendanceService.isAlreadyInCheckedOut(date: date);
        localAttendanceData = _attendanceService.getCheckDataByDate(date: date);
        if(localAttendanceData?.inTime != null){
          isCheckedIn = true;
        }
        if(localAttendanceData?.outTime != null){
          isCheckedOut = true;
          isCheckedIn = false;
        }
        if(localAttendanceData?.inTime != null && localAttendanceData?.outTime != null){
          isCheckedIn = false;
          isCheckedOut = false;
        }
        emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
      });
    } else {
      emit(state.copyWith(isCheckedIn: isCheckedIn, isCheckedOut: isCheckedOut, attendanceBody: localAttendanceData));
    }
  }

  @override
  Future<void> close() {
    onlineSubscription.cancel();
    offlineSubscription.cancel();
    return super.close();
  }
}
