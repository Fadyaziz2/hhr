import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/attendance/attendance_service.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import '../../../res/const.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final MetaClubApiClient _metaClubApiClient;
  final AttendanceService _attendanceService;
  final LocationServiceProvider _locationServices;
  final AttendanceType attendanceType;
  final InternetStatus _internetStatus;
  AttendanceBody body = AttendanceBody();
  final String? _selfie;

  AttendanceBloc(
      {required MetaClubApiClient metaClubApiClient,
      required AttendanceService attendanceService,
      required LocationServiceProvider locationServices,
      this.attendanceType = AttendanceType.normal,
      required InternetStatus internetStatus,
      String? selfie})
      : _metaClubApiClient = metaClubApiClient,
        _attendanceService = attendanceService,
        _locationServices = locationServices,
        _internetStatus = internetStatus,
        _selfie = selfie,
        super(const AttendanceState(status: NetworkStatus.initial)) {
    on<OnLocationInitEvent>(_onLocationInit);
    on<OnLocationRefreshEvent>(_onLocationRefresh);
    on<OnRemoteModeChanged>(_onRemoteModeUpdate);
    on<OnAttendance>(_onAttendance);
    on<OnLocationUpdated>(_onLocationUpdated);
    on<ReasonEvent>(_onReason);

    if (attendanceType == AttendanceType.qr ||
        attendanceType == AttendanceType.selfie ||
        attendanceType == AttendanceType.face) {
      ///for auto check in/out , we need to initialize location
      add(OnLocationInitEvent());

      ///----------------------------------------------------///
      ///if not normal attendance, this event call automatically
      add(OnAttendance());

      ///---------------///---------------------------------///
    }
  }

  void _onReason(ReasonEvent event, Emitter<AttendanceState> emit) async {
    body.reason = event.reasonData;
  }

  void _onLocationInit(
      OnLocationInitEvent event, Emitter<AttendanceState> emit) async {
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';

    ///Initialize attendance data at global state
    AttendanceData? attendanceData = event.dashboardModel?.data?.attendanceData;
    globalState.set(inTime, attendanceData?.inTime);
    globalState.set(outTime, attendanceData?.outTime);
    globalState.set(stayTime, attendanceData?.stayTime);

    add(OnLocationRefreshEvent());
  }

  void _onLocationUpdated(
      OnLocationUpdated event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(
        location: event.place, actionStatus: ActionStatus.location));
  }

  void _onLocationRefresh(
      OnLocationRefreshEvent event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(
        locationLoaded: false, actionStatus: ActionStatus.refresh));
    _locationServices.placeStream.listen((location) async {
      body.latitude = '${_locationServices.userLocation.latitude}';
      body.longitude = '${_locationServices.userLocation.longitude}';
      add(OnLocationUpdated(place: location));
    });
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(
        locationLoaded: true, actionStatus: ActionStatus.refresh));
  }

  void _onRemoteModeUpdate(
      OnRemoteModeChanged event, Emitter<AttendanceState> emit) {
    body.mode = event.mode;
    SharedUtil.setRemoteModeType(event.mode);
  }

  void _onAttendance(OnAttendance event, Emitter<AttendanceState> emit) async {
    emit(const AttendanceState(status: NetworkStatus.loading, actionStatus: ActionStatus.checkInOut));
    body.mode ??= await SharedUtil.getRemoteModeType() ?? 0;
    body.attendanceId = globalState.get(attendanceId);
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';
    body.selfieImage = _selfie;
    final selfieFile = body.selfieImage != null ?  await MultipartFile.fromFile(body.selfieImage!) : null;
    ///for offline attendance we need date, outTime, inTime
    body.date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
    final isCheckedIn = _attendanceService.isAlreadyInCheckedIn(date: body.date!);
    if (isCheckedIn) {
      body.outTime = DateFormat('h:mm a', 'en').format(DateTime.now());
    } else {
      body.inTime = DateFormat('h:mm a', 'en').format(DateTime.now());
    }
    ///---------------------******************-----------------------
    ///
    ///
    ///
    ///-----------------Device is online or Offline-----------------------------------
    if (_internetStatus == InternetStatus.online) {
      final checkInOutDataModel = FormData.fromMap(body.toOnlineJson(file: selfieFile));
      final checkInOut = await _metaClubApiClient.checkInOut(body: checkInOutDataModel);
      checkInOut.fold((l) {
        ///Exception from BE - In that scenario we
        ///have store data into local storage
        _attendanceService.checkInOut(checkData: body, isCheckedIn: isCheckedIn);

        final checkData = CheckData(
            message: 'Attendance successfully  completed. CHEERS!!!',
            result: true,
            checkInOut: convertToCheckout(body: body, inStatus: isCheckedIn ? 'check-in' : 'check-out'));

        updateGlobalState(
            attendanceId: body.attendanceId,
            inTime: body.inTime,
            outTime: body.outTime);

        emit(AttendanceState(status: NetworkStatus.success, checkData: checkData));
      }, (r) {
        ///Everything is fine and server response 200(okay)
        updateGlobalState(
            attendanceId: r?.checkInOut?.checkOut == null ? r?.checkInOut?.id : null,
            inTime: r?.checkInOut?.inTime,
            outTime: r?.checkInOut?.outTime,
            stayTime: r?.checkInOut?.stayTime);
        emit(AttendanceState(status: NetworkStatus.success, checkData: r));
      });
    } else {
      ///Internet not available for that case we need to store data
      ///in local storage for future sync with BE
      _attendanceService.checkInOut(checkData: body, isCheckedIn: isCheckedIn);
      final checkData = CheckData(
          message: 'Attendance successfully  completed. CHEERS!!!',
          result: true,
          checkInOut: convertToCheckout(body: body, inStatus: isCheckedIn ? 'check-in' : 'check-out'));

      updateGlobalState(attendanceId: body.attendanceId, inTime: body.inTime, outTime: body.outTime);

      emit(AttendanceState(status: NetworkStatus.success, checkData: checkData));
    }
  }

  void updateGlobalState({int? attendanceId, String? inTime, String? outTime, String? stayTime}) {
    globalState.set(attendanceId, attendanceId);
    globalState.set(inTime, inTime);
    globalState.set(outTime, outTime);
    globalState.set(stayTime, stayTime);
  }

  CheckInOut convertToCheckout(
      {required AttendanceBody body, String? inStatus}) {
    final checkData = CheckInOut(
        id: 0,
        remoteMode: body.mode,
        date: body.date,
        inTime: body.inTime,
        outTime: body.outTime,
        latitude: body.latitude,
        longitude: body.longitude,
        inStatus: inStatus);
    return checkData;
  }
}
