import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_track/location_track.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/app/global_state.dart';
import 'package:onesthrm/page/attendance/attendance.dart';
import 'package:onesthrm/page/home/home.dart';
import 'package:onesthrm/res/enum.dart';
import 'package:onesthrm/res/shared_preferences.dart';
import '../../../res/const.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final MetaClubApiClient _metaClubApiClient;
  final LocationServiceProvider _locationServices;
  final AttendanceType attendanceType;
  AttendanceBody body = AttendanceBody();
  final String? _selfie;

  AttendanceBloc(
      {required MetaClubApiClient metaClubApiClient,
      required LocationServiceProvider locationServices, this.attendanceType = AttendanceType.normal, String? selfie})
      : _metaClubApiClient = metaClubApiClient,
        _locationServices = locationServices,
        _selfie = selfie,
        super(const AttendanceState(status: NetworkStatus.initial)) {
    on<OnLocationInitEvent>(_onLocationInit);
    on<OnLocationRefreshEvent>(_onLocationRefresh);
    on<OnRemoteModeChanged>(_onRemoteModeUpdate);
    on<OnAttendance>(_onAttendance);
    on<OnLocationUpdated>(_onLocationUpdated);
    on<ReasonEvent>(_onReason);

    if(attendanceType == AttendanceType.qr || attendanceType == AttendanceType.selfie || attendanceType == AttendanceType.face){
      ///for auto check in/out , we need to initialize location
      add(OnLocationInitEvent());
      ///----------------------------------------------------///
      ///if not normal attendance, this event call automatically
      add(OnAttendance());
      ///---------------///---------------------------------///
    }
  }

  void _onReason(ReasonEvent event,Emitter<AttendanceState> emit)async {
    body.reason = event.reasonData;
  }
  void _onLocationInit(OnLocationInitEvent event, Emitter<AttendanceState> emit) async {
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';

    ///Initialize attendance data at global state
    AttendanceData? attendanceData = event.dashboardModel?.data?.attendanceData;
    globalState.set(inTime, attendanceData?.inTime);
    globalState.set(outTime, attendanceData?.outTime);
    globalState.set(stayTime, attendanceData?.stayTime);

    add(OnLocationRefreshEvent());
  }

  void _onLocationUpdated(OnLocationUpdated event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(location: event.place,actionStatus: ActionStatus.location));
  }

  void _onLocationRefresh(OnLocationRefreshEvent event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(locationLoaded: false,actionStatus: ActionStatus.refresh));
    _locationServices.placeStream.listen((location) async {
      body.latitude = '${_locationServices.userLocation.latitude}';
      body.longitude = '${_locationServices.userLocation.longitude}';
      add(OnLocationUpdated(place: location));
    });
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(locationLoaded: true,actionStatus: ActionStatus.refresh));
  }

  void _onRemoteModeUpdate(OnRemoteModeChanged event, Emitter<AttendanceState> emit) {
    body.mode = event.mode;
    SharedUtil.setRemoteModeType(event.mode);
  }

  void _onAttendance(OnAttendance event, Emitter<AttendanceState> emit) async {
    emit(const AttendanceState(status: NetworkStatus.loading,actionStatus: ActionStatus.checkInOut));
    body.mode ??= await SharedUtil.getRemoteModeType() ?? 0;
    body.attendanceId = globalState.get(attendanceId);
    body.latitude = '${_locationServices.userLocation.latitude}';
    body.longitude = '${_locationServices.userLocation.longitude}';
    body.selfieImage =  _selfie != null ? await MultipartFile.fromFile(_selfie.toString(), filename: _selfie.toString()) : null;
    final checkInOutDataModel = FormData.fromMap(body.toJson());
    final checkInOut = await _metaClubApiClient.checkInOut(body: checkInOutDataModel);
    globalState.set(attendanceId, checkInOut?.checkInOut?.checkOut == null ? checkInOut?.checkInOut?.id : null);
    globalState.set(inTime, checkInOut?.checkInOut?.inTime);
    globalState.set(outTime, checkInOut?.checkInOut?.outTime);
    globalState.set(stayTime, checkInOut?.checkInOut?.stayTime);
    emit(AttendanceState(status: NetworkStatus.success, checkData: checkInOut));
  }
}
