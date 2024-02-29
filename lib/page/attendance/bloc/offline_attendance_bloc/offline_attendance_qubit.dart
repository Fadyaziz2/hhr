import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesthrm/page/app/app.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/event_bus/offline_data_sync_event.dart';
import 'package:onesthrm/res/event_bus/on_offline_attendance_update_event.dart';
import 'offline_attendance_state.dart';

class OfflineCubit extends Cubit<OfflineAttendanceState> {
  final AttendanceService _attendanceService;

  OfflineCubit({required AttendanceService attendanceService})
      : _attendanceService = attendanceService,
        super(const OfflineAttendanceState()){

    onCheckInOutData();

    eventBus.on<OnOfflineAttendanceUpdateEvent>().listen((event) {
      onCheckInOutData(body: event.body);
    });
  }

  onCheckInOutData({AttendanceBody? body}){
    final date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    bool isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: date);
    bool isCheckedOut = _attendanceService.isAlreadyInCheckedOut(date: date);
    AttendanceBody? localAttendanceData = _attendanceService.getCheckDataByDate(date: date);

    if(body != null) {
      ///for offline attendance we need date, outTime, inTime
      if (isCheckedIn && isCheckedOut == false) {
        body = body.copyWith(inTime: localAttendanceData?.inTime);
        body = body.copyWith(outTime:  DateFormat('h:mm a', 'en').format(DateTime.now()));
      } else {
        body = body.copyWith(inTime: DateFormat('h:mm a', 'en').format(DateTime.now()));
        body = body.copyWith(outTime:  null);
      }

      _attendanceService.checkInOut(checkData: body, isCheckedIn: isCheckedIn,isCheckedOut: isCheckedOut,multipleAttendanceEnabled: true).then((_){
        isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: date);
        isCheckedOut = _attendanceService.isAlreadyInCheckedOut(date: date);
        localAttendanceData = _attendanceService.getCheckDataByDate(date: date);
        if(isCheckedOut){
        ///-----------------------Try to sync attendance data with server when user try to checkout---------------
          eventBus.fire(const OfflineDataSycEvent());
        }
        ///--------------------------------------*********--------------------------------------------------------
        emit(state.copyWith(isCheckedIn: isCheckedIn,isCheckedOut: isCheckedOut,attendanceBody: localAttendanceData));
      });
    }else{
      emit(state.copyWith(isCheckedIn: isCheckedIn,isCheckedOut: isCheckedOut,attendanceBody: localAttendanceData));
    }
  }

}
